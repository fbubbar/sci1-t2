
import numpy as np

from manim import *

class Ellipsoid(ThreeDScene):
    def construct(self):
        axes = ThreeDAxes()
        self.add(axes)
        self.set_camera_orientation(phi=75 * DEGREES, theta=-PI/4)
        self.begin_ambient_camera_rotation(rate=PI)

        I = np.array([3, 2, 1])
        omega = np.array([0, 1, 0])
        E = 1/2 * np.dot(I, omega)

        dims = np.sqrt(2 * E * I)
        ellipsoid = self.make_ellipsoid(*dims)
        self.add(ellipsoid)

        L = np.sqrt(np.dot(I**2, omega**2))
        sphere = self.make_sphere(L).set_fill(color=GREEN)
        self.add(sphere)

        self.wait(2)

    def make_sphere(self, r):
        return self.make_ellipsoid(r, r, r)

    def make_ellipsoid(self, a, b, c):
        ellipsoid = Surface(
            checkerboard_colors=False,
            resolution=(100, 100),
            stroke_width=0,
            fill_opacity=0.9,

            # parametric equations
            u_range=(0, 2 * PI),
            v_range=(0, PI),
            func=lambda u, v: np.array([
                a * np.sin(v) * np.cos(u),
                b * np.sin(v) * np.sin(u),
                c * np.cos(v)
            ])
        )
        return ellipsoid

