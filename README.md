## Kant-comerce

### How to install:
- After cloning the repo you should get in the folder and run bundle install.

### Running tests:
- You can run each test individually by running in the console:ruby test/name_of_folder/name_of_the_test.rb
- Also you can run all the tests by running in the root of the project: rake test

### Checking results and running the evaluation use cases
- The use cases specified in the description of the exercise are already defined in the checkout_test.rb but also they can be "tested" running ruby run.rb in the root of the folder.

### Special consideration
- Although the pricing rules are applied as expected in all cases I couldn't figure out how should be rounded/treated the total price in the 4th use case where my approach is 0.11 inaccurate.
