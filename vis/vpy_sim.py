from vpython import *
import numpy as np

# Create the 3D scene
scene = canvas(title="Dzhanibekhov Effect")

# Define box dimensions (length, width, height)
length = 14.4
width = 7.1
height = 0.8

# Create the box (representing the rigid body)
box_object = box(pos=vector(0, 0, 0), size=vector(length, width, height), color=color.purple)

# Density is assumed to be 1 (unit mass per unit volume)
density = 1.0
mass = density * length * width * height  # Volume * density

# Moments of inertia (calculated based on the box dimensions)
I1 = (1/12) * mass * (width**2 + height**2)  # about x-axis
I2 = (1/12) * mass * (length**2 + height**2)  # about y-axis
I3 = (1/12) * mass * (length**2 + width**2)   # about z-axis

# Initial angular velocity
omega = np.array([0.0, 2, 0.01])  # small deviation in x and z axes

# Inertia tensor (diagonal)
I = np.diag([I1, I2, I3])

# Time step for the simulation
dt = 0.001
time = 0

# Create a graph for angular velocity and angular momentum
g = graph(width=600, height=400, title="Angular Velocity and Momentum", xtitle="Time (s)", ytitle="Value")

# Create curves for angular velocity and angular momentum
angular_velocity_curve_x = gcurve(graph=graph, color=color.green, label="Angular Velocity in x-axis")
angular_velocity_curve_y = gcurve(graph=graph, color=color.blue, label="Angular Velocity in y-axis")
angular_velocity_curve_z = gcurve(graph=graph, color=color.red, label="Angular Velocity in z-axis")
#angular_momentum_curve = gcurve(graph=graph, color=color.red, label="Angular Momentum")

# Function to update the rotation of the box based on angular velocity
def update_rotation(omega=omega):
    global time
    # Calculate angular acceleration using Euler's equations of motion
    omega_dot = np.zeros(3)
    omega_dot[0] = (I2 - I3) * omega[1] * omega[2] / I1
    omega_dot[1] = (I3 - I1) * omega[0] * omega[2] / I2
    omega_dot[2] = (I1 - I2) * omega[0] * omega[1] / I3
    
    # Update angular velocity
    omega += omega_dot * dt
    angular_momentum = np.dot(I, omega)  # Angular momentum = I * omega
    total_angular_momentum = np.linalg.norm(angular_momentum)  # Magnitude of angular momentum
    angular_velocity_curve_x.plot(pos=(time, omega[0]))  # Plot angular velocity magnitude
    angular_velocity_curve_y.plot(pos=(time, omega[1]))  # Plot angular velocity magnitude
    angular_velocity_curve_z.plot(pos=(time, omega[2]))  # Plot angular velocity magnitude
    #angular_momentum_curve.plot(pos=(time, total_angular_momentum))  # Plot angular momentum magnitude

    
    # Update orientation of the box based on angular velocity
    box_object.rotate(angle=np.linalg.norm(omega) * dt, axis=vector(*omega) / np.linalg.norm(omega))

    # Update time
    time += dt

# Simulate the effect over time
while True:
    rate(1/dt)  # Run the simulation at 1/dt frames per second
    update_rotation()  # Update the rotation of the box
