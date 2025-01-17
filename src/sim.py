import numpy as np
from numpy.linalg import norm
from math import prod

from manim import *

class Dzhanibekhov(MovingCameraScene):
    def setup(self):
        self.dims = (14.4, 7.1, 0.8)
        self.rho = 1.0
        self.run_t = 5 # s

        # computed properties
        vol = prod(self.dims)
        mass = self.rho * vol
        l, w, h = self.dims

        # inertia tensor
        c = 1/12
        self.Ix = c * mass * (w**2 + h**2)
        self.Iy = c * mass * (l**2 + h**2)
        self.Iz = c * mass * (l**2 + w**2)
        self.I = np.diag([self.Ix, self.Iy, self.Iz])

        # initial angular velocity & momentum
        self.omega = np.array([0.0, 3.0, 0.01])
        self.L = np.dot(self.I, self.omega)

    def update_rotation(self, box, dt):
        substeps = 100
        subdt = dt / substeps
        for _ in range(substeps):
            # get angular acc. using the Euler equations
            wx, wy, wz = self.omega
            alpha = np.array([
                (self.Iy - self.Iz) * wy * wz / self.Ix,
                (self.Iz - self.Ix) * wx * wz / self.Iy,
                (self.Ix - self.Iy) * wx * wy / self.Iz,
            ])

            # update angular velocity
            self.omega += alpha * subdt
            self.L = np.dot(self.I, self.omega)

            # rotate the box
            dtheta = norm(self.omega) * subdt
            axis = self.omega / norm(self.omega)
            box.rotate(angle=dtheta, axis=axis)

    def construct(self):
        self.camera.frame.scale(2.0)
    
        box = Cube(side_length=1).scale(self.dims)
        box.set_fill(BLUE, opacity=0.7)
        box.set_stroke(color=WHITE, width=2)
        self.add(box)

        box.add_updater(self.update_rotation)

        # Create axes for the angular velocity graph
        axes = Axes(
            x_range=[0, self.run_t, 5],
            y_range=[-3, 3, 10],
            x_length=6,
            y_length=3,
            axis_config={"include_numbers": True},
            tips=False
        ).to_corner(UR).shift(LEFT)

        axes_labels = axes.get_axis_labels(x_label=Text("t"), y_label=Text("ω"))

        self.add(axes, axes_labels)

        # Initialize time tracker
        time_tracker = ValueTracker(0)

        # Function to create the angular velocity graphs
        def update_graphs():
            t = time_tracker.get_value()

            # Create lines for each angular velocity component
            omega_x_point = axes.c2p(t, self.omega[0])
            omega_y_point = axes.c2p(t, self.omega[1])
            omega_z_point = axes.c2p(t, self.omega[2])

            omega_x_graph = Line(start=axes.c2p(0, self.omega[0]), end=omega_x_point, color=RED)
            omega_y_graph = Line(start=axes.c2p(0, self.omega[1]), end=omega_y_point, color=GREEN)
            omega_z_graph = Line(start=axes.c2p(0, self.omega[2]), end=omega_z_point, color=BLUE)
            print(f"t = {time_tracker.get_value():.2f}, ω = {self.omega}")

            return omega_x_graph, omega_y_graph, omega_z_graph

        # Use always_redraw to continuously update the graphs
        omega_x_graph, omega_y_graph, omega_z_graph = update_graphs()

        # Add the graphs to the scene
        self.add(omega_x_graph, omega_y_graph, omega_z_graph)

        # Attach the updater to each graph (individual lines)
        omega_x_graph.add_updater(
            lambda m, dt: (
                time_tracker.increment_value(dt),
                print(f"t = {time_tracker.get_value():.2f}, ω = {self.omega}"),
                m.set_points_as_corners([axes.c2p(time_tracker.get_value(), self.omega[0])])
            )[2]
        )
        omega_y_graph.add_updater(
            lambda m, dt: m.set_points_as_corners([axes.c2p(time_tracker.get_value(), self.omega[1])])
        )
        omega_z_graph.add_updater(
            lambda m, dt: m.set_points_as_corners([axes.c2p(time_tracker.get_value(), self.omega[2])])
        )

        self.wait(self.run_t)

# render
config.quality = "low_quality"
config.output_file = "Dzhanibekhov.mp4"
scene = Dzhanibekhov()
scene.render()
