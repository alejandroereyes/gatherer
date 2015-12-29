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
        <li>Use <b>"S.W.I.F.T."</b> criteria to evaluate test quality
          <ol>
            <li><b>Straightforward:</b> it's purpose is immediately understandable.</li>
            <li><b>Well Defined:</b> running the same test repeatedly gives the same result.</li>
            <li><b>Independent:</b> it's not dependent on any other tests or external data to run.</li>
            <li><b>Fast:</b> As the code base grows, so do tests that take up more time.</li>
            <li><b>Truthful:</b> accurately reflects the underlying code-it passes when the underlying code works, and fails when it does not. This is easier said then done.</li>
          </ol>
        </li>
      </ul>
    </li>
    <li>If you find yourself writing tests that already pass given the current state of the code, that often means your'e writing too much code in each pass.</li>
    <li>Refactoring is where a lot of design happens in TDD, and it's easiest to do in small steps.
      <ul>
      <li>Break up complexity</li>
      <li>Combine duplication</li>
      <li>Look for abstractions waiting to be found</li>
      </ul>
    </li>
    <li>Try to extract methods when you see compound Booleans, local variables, or inline comments.</li>
    <li>Fixtures are particularly useful for global semi-static data stored in the database.</li>
    <li>The go-to build strategy when using `FactoryGirl` should be `build_stubbed` unless there is a need for the object to be in the database during the test.</li>
    <li>Avoid defining associations automatically in factory definitions. Set them test by test, as needed. You'll wind up with more manageable test data.</li>
    <li>Use partial doubles when you want to ensure most of your object behavior. User full doubles when the behavior of the stubbed object doesn't matter-only its public interface does.</li>
    <li>The use of the `allow_any_instance_of` stub often means the underlying code could be refactored with a more useful method to stub.</li>
    <li>If you're stubbing methods that don't belong to your program(like ActiveRecord methods), think about whether the code would be better if restructured to wrap the external behavior.</li>
    <li>A stubbed method that returns a stub is usually okay. A <b>stubbed method that returns a stub that itself contains a stub</b> probably means your code is <b>too dependent on the internals of other objects.</b></li>
    <li>Don't mock what you don't own.</li>
    <li>A controller test should test <b>controller</b> behavior. A controller test <b>should not fail because of problems in the model.</b>
      <ul>
        <li>It should verify that a normal, basic user request triggers expected model calls & passes the necessary data to the view.</li>
        <li>Verify that an ill-informed or otherwise invalid user request is handled appropriately.</li>
        <li>Verify security, such as requiring logins for pages as needed & testing that users who enter a URL for a resource they shouldn't have access to are blocked or diverted.</li>
      </ul>
    </li>
    <li>When testing for view elements, try to test for DOM classes that you control rather than text or element names that might be subject to design changes.</li>
    <li>When testing a Boolean condition, make sure to write a test for both halves o the condition.</li>
    <li>By for the biggest & easiest trap you can fall into when dealing with integration tests is the temptation to use them like unit tests.
      <ul>
        <li><b>Good:</b> The interaction between a controller & the model, or other objects that provide data.</li>
        <li><b>Good:</b> The interaction between multiple controller actions that comprise a common workflow.</li>
        <li><b>Good:</b> Certain security issues that involve the interaction between a user state and a particular controller action.</li>
        <li><b>Bad:</b> Special cases of logic, such as what happens if data is nil or has an unexpected value.</li>  
        <li><b>Bad:</b> Error cases, unless an error case genuinely results in a unique user experience.</li>
        <li><b>Bad:</b> Internal implementation details of logic.</li>
      </ul>
    </li>
    <li>Security issues are, at base, just bugs. Most of the practices you follow to keep your code bug-free will also help prevent and diagnose security issues.</li>
    <li>Always do security testing in pairs: the blocked logic and the okay logic.</li>
    <li>When a single change in your code breaks multiple tests, consider the idea that your testing strategy is flawed.</li>
    <li>Write your test as close as possible to the code logic that's being tested.</li>
    <li>Adding user authentication can be very disruptive to existing tests. Try to get the basic infrastructure in place early.</li>
    <li>Test for mass assignment any time you have an attribute that needs to be secure and a controller method that touches that class based on user input.</li>
    <li>Use an automatic security scanner to check for common security issues.</li>
    <li>Mediating interaction to an external server through an adapter that is part of your code makes the interaction easier to test and to use.</li>
    <li>Use the VCR gem to allow your integration tests to run against server response data.</li>
    <li>Use an adapter to test client behavior without being dependent on the server API.
      <ul>
        <li>External Service can accessed from multiple points in your code.</li>
        <li>Interaction with ES has logic of its own, such as authentication or type changing or common sets of options.</li>
        <li>Handles any mismatch between the language or metaphor of the API and the domain terms and structures of your code.</li>
      </ul>
    </li>
    <li>Test the error code based on which object in the system needs to respond to the error.</li>
    <li>User JavaScript testing to help design your JavaScript code to allow for modular items with few tangled interdependencies.</li>
    <li>Create only as many DOM elements or data as needed for the test to run.</li>
  </ol>
