# Gatherer
  This app is a tutorial taken from [Rails 4 Test Prescriptions](https://pragprog.com/book/nrtest2/rails-4-test-prescriptions) in order to learn more about testing.

### Test Prescriptions
  <ol>
    <li>User the TDD process to create and adjust your code's design in small, incremental steps.</li>
    <li>In a test-driven process, if it is difficult to write tests for a feature, strongly consider the possibility that the underlying code needs to be changed.</li>
    <li>Initializing objects is a good starting place for a TDD process. Another good approach is to use the test to design what you want a successful interaction of the feature to look like.</li>
    <li>When possible, write your tests to describe your code's behavior, not its implementation.</li>
    <li>Keeping your code as simple as possible allows you to focus complexity on the areas that really need complexity.</li>
    <li>Choose your test data and test-variable names to make it easy to diagnose failures when they happen. Meaningful names and data that doesn't overlap are helpful.</li>
    <li>Test isolation makes it easier to understand test failures by limiting the scope of potential locations where the failure might have occurred.</li>
    <li>Your tests are also code. Specifically, your tests are code that does not have tests.
      <ul>
        <li>Having your tests be as clear and manageable as possible is the only way to keep them honest.</li>
      <ul></li>
  <ol>
