driver <- 1
trip <- sample(1:200,9)
trip <- c(83,102,120,136,148,183,200)

par(mfcol=c(3,3))
for (i in trip){
    files <- paste0(path, driver, '/', i, ".csv")
    trip_data <- data.matrix(fread(files, header=T, sep="," ,stringsAsFactor=F))
    trip_data <- Kalman_Filter(trip_data,1,1,12.5) #Q_metres_per_second = 50*1000/3600
    
    cur <- calcCurvature(trip_data,1)
    
    a <- trip_data[which(cur[,3]<=100),]
    plot(trip_data)
    lines(a,type = 'o',col='red')    
    
}

for (i in trip){
    files <- paste0(path, driver, '/', i, ".csv")
    trip_data <- data.matrix(fread(files, header=T, sep="," ,stringsAsFactor=F))
    trip_data <- Kalman_Filter(trip_data,1,1,12.5) #Q_metres_per_second = 50*1000/3600
    
    speed <- calcSpeed(trip_data)
    speed_o <- removeOutliers(speed,9.8)
    plot(speed)
    lines(speed_o,col='red')
    #lines(a,type = 'o',col='red')    
}

# driver trip
# 83       1   83
# 102      1  102
# 120      1  120
# 136      1  136
# 148      1  148
# 183      1  183
# 200      1  200
# 345      2  145
# 393      2  193
# 551      3  151
# 589      3  189

plot(trip_data)
points(trip_data[-1,][which(heading>=90),],col='red')


### new test ###
trip <- matrix(c(0,0,1,0.1,2,-1),nrow = 3,byrow = T)
trip_p <- Cartesian_to_Polar(trip,1)
plot(trip)
degree_cal(trip_p,1)

trip_p <- Cartesian_to_Polar(trip_data,3)
angle <- degree_cal(trip_p,3)

tp <- which(angle >= 45)
plot(trip_data);points(trip_data[tp,],col='red')

trip <- trip_data[jp,][tp,]
plot(trip)
