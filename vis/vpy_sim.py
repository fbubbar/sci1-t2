from vpython import *
import numpy as np

# Create the 3D scene
scene = canvas(title="Dzhanibekov Effect")

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
dt = 0.01
time = 0

# Create a graph for angular velocity and angular momentum
g = graph(width=600, height=400, title="Angular Velocity on 3 axes", xtitle="Time (s)", ytitle="Value")

# Create curves for angular velocity and angular momentum
angular_velocity_curve_x = gcurve(graph=g, color=color.green, label="Angular Velocity in x-axis")
angular_velocity_curve_y = gcurve(graph=g, color=color.blue, label="Angular Velocity in y-axis")
angular_velocity_curve_z = gcurve(graph=g, color=color.red, label="Angular Velocity in z-axis")

# Create a second canvas for angular momentum visualization
scene2 = canvas(title="Angular Momentum Space", width=600, height=600)
scene2.background = color.black

# Position and orient the camera for scene2
scene2.camera.pos = vector(0, 0, 50)
scene2.camera.axis = vector(0, 0, -50)

# Compute initial angular momentum and kinetic energy (conserved)
angular_momentum = np.dot(I, omega)
L0 = np.linalg.norm(angular_momentum)
T0 = 0.5 * (I1*omega[0]**2 + I2*omega[1]**2 + I3*omega[2]**2)

# Define the semi-axes of the energy ellipsoid:
a_axis = np.sqrt(2 * T0 * I1)  # Correct formula for semi-axis
b_axis = np.sqrt(2 * T0 * I2)  # Correct formula for semi-axis
c_axis = np.sqrt(2 * T0 * I3)  # Correct formula for semi-axis

# Create the momentum sphere (all L vectors with |L| = L0)
momentum_sphere = sphere(canvas=scene2, pos=vector(0,0,0), radius=L0,
                         color=color.cyan, opacity=0.2)

# Create the energy ellipsoid
energy_ellipsoid = ellipsoid(canvas=scene2, pos=vector(0,0,0),
                             length=2*a_axis, height=2*b_axis, width=2*c_axis,
                             color=color.magenta, opacity=0.2)

# Create a small red sphere to indicate the current angular momentum vector
current_point = sphere(canvas=scene2, pos=vector(*angular_momentum),
                       radius=0.05*L0, color=color.red)
                       
# Create a trail to show the path of the angular momentum vector
trail = curve(canvas=scene2, color=color.yellow, radius=0.01*L0)

# Function to update the rotation of the box based on angular velocity
def update_rotation():
    global time, omega, angular_momentum
    
    # Calculate angular acceleration using Euler's equations of motion
    omega_dot = np.zeros(3)
    omega_dot[0] = (I2 - I3) * omega[1] * omega[2] / I1
    omega_dot[1] = (I3 - I1) * omega[0] * omega[2] / I2
    omega_dot[2] = (I1 - I2) * omega[0] * omega[1] / I3
    
    # Update angular velocity
    omega += omega_dot * dt
    
    # Update angular momentum
    angular_momentum = np.dot(I, omega)
    
    # Plot angular velocity components
    angular_velocity_curve_x.plot(pos=(time, omega[0]))
    angular_velocity_curve_y.plot(pos=(time, omega[1]))
    angular_velocity_curve_z.plot(pos=(time, omega[2]))
    
    # Update the position of the red point in the angular momentum space
    current_point.pos = vector(*angular_momentum)
    
    # Add point to the trail
    trail.append(pos=vector(*angular_momentum))
    
    # Update orientation of the box based on angular velocity
    omega_magnitude = np.linalg.norm(omega)
    if omega_magnitude > 0:  # Avoid division by zero
        box_object.rotate(angle=omega_magnitude * dt, axis=vector(*omega) / omega_magnitude)
    
    # Update time
    time += dt

# Main simulation loop
while True:
    rate(100)  # Adjust for smoother animation
    update_rotation()
