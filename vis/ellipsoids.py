
import numpy as np

from manim import *

class Ellipsoid(ThreeDScene):
    def construct(self):
        axes = ThreeDAxes()
        self.add(axes)

        theta = PI/4
        x_label = axes.get_x_axis_label('L_1') \
            .rotate(PI/2, axis=RIGHT) \
            .rotate(theta, axis=OUT) \
            .shift(0.1 * LEFT)
        y_label = axes.get_y_axis_label('L_2') \
            .rotate(PI/2, axis=RIGHT) \
            .rotate(PI/2, axis=UP) \
            .rotate(theta, axis=OUT) \
            .shift(0.50 * RIGHT) \
            .shift(0.90 * OUT)
        z_label = axes.get_z_axis_label('L_3') \
            .rotate(theta, axis=OUT) \
            .shift(0.25 * RIGHT)
        self.add(x_label, y_label, z_label)

        self.set_camera_orientation(phi=75 * DEGREES, theta=-theta)
        # self.begin_ambient_camera_rotation(rate=PI)

        I = np.array([3, 2, 1])
        omega0 = np.array([0, 1, 0])

        E = 1/2 * np.dot(I, omega0**2)

        dims = np.sqrt(2 * E * I)
        ellipsoid = self.make_ellipsoid(*dims, op=0.5)
        self.add(ellipsoid)

        L = np.sqrt(np.dot(I**2, omega0**2))
        sphere = self.make_sphere(L+0.01, op=0.6).set_fill(color=GREEN)
        self.add(sphere)

    def make_sphere(self, r, op):
        return self.make_ellipsoid(r, r, r, op)

    def make_ellipsoid(self, a, b, c, op):
        return Surface(
            checkerboard_colors=False,
            resolution=(100, 100),
            stroke_width=0,
            fill_opacity=op,

            # parametric equations
            u_range=(0, 2 * PI),
            v_range=(0, PI),
            func=lambda u, v: np.array([
                a * np.sin(v) * np.cos(u),
                b * np.sin(v) * np.sin(u),
                c * np.cos(v)
            ])
        )
