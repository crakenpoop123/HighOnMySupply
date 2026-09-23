noise_level = 0.0
noise_rate = 150
min_noise_rate = 20
has_surpassed_min = False


count = 0
while noise_level < 1:
    count += 1

    delta = 1/60
    
    # Used for quadratic noise scaling
    noise_grad = 2 * noise_level # Gradient of x^2
	
	# Gets the time since the last frame, normalised by the noise rate 
    time_change = delta / noise_rate
	
	# The amount to increase the noise by
    noise_increase = max(noise_grad * time_change, time_change / min_noise_rate) 

    if has_surpassed_min != True and noise_grad * time_change > time_change / min_noise_rate:
        has_surpassed_min = True
        print("noise surpassed min in : ", count, " frames")
        print("noise surpassed min in : ", count / 60, " seconds")
        print("noise surpassed min in : ", count / 3600, " minutes")
	
	# Increase noise
    noise_level += noise_increase

print("noise reached 1 in : ", count, " frames")
print("noise reached 1 in : ", count / 60, " seconds")
print("noise reached 1 in : ", count / 3600, " minutes")