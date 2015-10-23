# Code Book for the HARUS data set 

## Data source:

The raw data corresponds to the Human Activity Recognition Using Smartphones Data Set stored in the UC Irvine Machine Learning Repository: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data was obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip in October 22th 2015.

## Experiment Design

The experiments were carried out with 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured.

## Summary choices

* "subject" and "activity" colums are added to test and training sets as factors.
* "activity" factors are renamed to its description.
* Test and training sets are merged in a single data frame.
* Only variable names containing "-mean()" and "-std()" strings, as well as "subject" and "activity" are kept.
* Variable names are renamed to be more descriptive according to the following replacement rules:

| Original string | New string      |
|-----------------|-----------------|
| "Acc"           | "Acceleration"  |
| "Gyro"          | "Gyroscope"     |
| "Mag"           | "Magnitude"     |
| "-mean()"       | "Mean"          |
| "-std()"        | "Std"           |
| "-X"            | "X"             |
| "-Y"            | "Y"             |
| "-Z"            | "Z"             |
| "BodyBody"      | "Body"          |
| "^f"            | "Freq"          |
|"^t"             | "Time"          |

* The data set is grouped by "subject" and "activity" and the mean of values for the rest of variables are obtained for each group. The combination of 30 subjects and 6  activities generate 180 observations for 68 variables.

## Variables

The tidy datase contains 180 observations and 68 variables.
An observation is the set of measures for different variables taken for each subject and activity combination.

1. **activity**: Activity performed when the data was collected. Factor of 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

2. **subject**:  Subject that performed the activity. Factor from 1 to 30

3. The rest of the 66 variables provide information obtained from the accelerometer and the gyroscope.
The names of the variables are formatted in camel case according to the following scheme:
```
DomainSignalAxisMeasure
```
* Domain: Time domain signals (Time) or frequency domain signals after a Fast Fourier Transform is applied (Freq).
* Signal: Signals obtained from the Gyroscope or the Accelerometer captured at a rate of 50 Hz. 
* Measure: Mean or standard deviation (Std). Measures applied to the signal.
* Axis: Direction (X, Y, Z). Empty if not applicable.

The variables and their names can be obtained combining each of the domains, signals, measures and axis according to the following table:

| Domain    | Signal                        | Axis    | Masure    |
|-----------|-------------------------------|---------|-----------|
|Time, Freq | BodyAcceleration              | X, Y, Z | Mean, Std | 
|Time       | GravityAcceleration           | X, Y, Z | Mean, Std | 
|Time, Freq | BodyAccelerometerJerk         | X, Y, Z | Mean, Std |
|Time, Freq | BodyGyroscope                 | X, Y, Z | Mean, Std |
|Time       | BodyGyroscopeJerk             | X, Y, Z | Mean, Std |
|Time, Freq | BodyAccelerationMagnitude     |         | Mean, Std |          
|Time       | GravityAccelerometerMagnitude |         | Mean, Std |    
|Time, Freq | BodyAccerometerJerkMagnitude  |         | Mean, Std |      
|Time, Freq | BodyGyroscopeMagnitude        |         | Mean, Std |         
|Time, Freq | BodyGyroscopeJerkMagnitude    |         | Mean, Std |     

All variables are numeric.  Variables for Acceleration and Gyroscope signals are accelerations(m/s^2) and the units for variables with Jerk signals are m/s^3.



  
    
