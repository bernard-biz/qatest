# our base image
FROM ruby:2.4-onbuild

# run the application
CMD ["rspec", "./tester_work/spec"]
