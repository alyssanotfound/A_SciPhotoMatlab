f := plot::Function3d(sin(x^2 - y^2), x = -2..2, y = -2..2, 
                      Color = RGB:White):
light := plot::DistantLight([3, 4, 5], [0, 0, 0], 0.75,
                            Color = RGB:Yellow): 
camera := plot::Camera([3, 4, 5], [0, 0, 0], 0.25*PI):
plot(f, light, camera)