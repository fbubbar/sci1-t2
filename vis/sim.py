import numpy as np
from numpy.linalg import norm
from math import prod

from manim import *

class Dzhanibekhov(MovingCameraScene):
    def setup(self):
        self.dims = (14.4, 7.1, 0.8)
        self.rho = 1.0
        self.run_t = 30.0 # s

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
        self.wait(self.run_t)

