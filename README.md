![CI](https://github.com/wkennedy/password-validation/workflows/CI/badge.svg)

### Simple Perl Password Validator

This application will allow you to verify that a password meets the following criteria:

- Passwords must be at least 8 characters long.
- Between 8-11: requires mixed case letters, numbers and symbols
- Between 12-15: requires mixed case letters and numbers
- Between 16-19: requires mixed case letters
- 20-128: any characters desired
- Passwords can't be longer than 128 characters

To view a demo of the application, go here (deployed on AWS ECS):

http://ec2co-ecsel-zg9ctrfgctou-1940750782.us-east-1.elb.amazonaws.com:3000/

If you just want to run the application via the command line you can do so with:

    #windows
    perl ValidatePassword.pl <password>
    
Otherwise, if you want to run the web application:

    #To run the web application
    morbo ./script/application.pl

or to build and run a Docker image:

    #Build the image
    docker build -t perl_password_validator .
    
    #Run the image
    docker run -it --rm -p 3000:3000 perl_password_validator
    
or if you just want to run the Docker image from my repo:

    docker run -it --rm -p 3000:3000 waggins/perl_password_validator:v1
