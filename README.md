[![Build Status](https://travis-ci.org/alejandroereyes/gatherer.svg?branch=master)](https://travis-ci.org/alejandroereyes/gatherer)  [![Test Coverage](https://codeclimate.com/github/alejandroereyes/gatherer/badges/coverage.svg)](https://codeclimate.com/github/alejandroereyes/gatherer/coverage)  [![Code Climate](https://codeclimate.com/github/alejandroereyes/gatherer/badges/gpa.svg)](https://codeclimate.com/github/alejandroereyes/gatherer)

# Gatherer
  This tutorial is taken from [Rails 4 Test Prescriptions](https://pragprog.com/book/nrtest2/rails-4-test-prescriptions) in order to learn more about testing.

#### [Code Snippets](https://github.com/alejandroereyes/gatherer/blob/master/notes/code_snippets_with_notes.md) - <kbd>Code with inline notes.</kbd>

#### Test Prescriptions
  <ol>
    <li>Use the TDD process to create and adjust your code's design in small, incremental steps.</li>
    <li>In a test-driven process, <b>if it is difficult to write tests for a feature</b>, strongly consider the possibility that the <b>underlying code needs to be changed</b>.</li>
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
    <li>When testing a Boolean condition, make sure to write a test for both halves of the condition.</li>
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
    <li><b>When a single change in your code breaks multiple tests, consider the idea that your testing strategy is flawed.</b></li>
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
    <li>Use JavaScript testing to help design your JavaScript code to allow for modular items with few tangled interdependencies.</li>
    <li>Create only as many DOM elements or data as needed for the test to run.</li>
    <li>Jasmine spies replace a function object with a spy object that keeps track of how often the function is called.</li>
    <li>Treating the DOM as an external service that you relate to via an adapter can lead to very maintainable JavaScript code.</li>
    <li>Use Capybara's JavaScript integration-testing capabilities sparingly lest you be very, very annoyed. Test as much as possible within each layer, separate from the others.</li>
    <li>When a formerly passing test fails, something has changed.</li>
    <li>Using `p` and various related methods is a quick & easy way to get a sense of why a test is behaving badly.</li>
    <li>Use `git bisect` to track down mysterious failures in your code when you have no idea how they were inserted.
      <ul>
      <li>The problem needs to have been caused by a code change, not a change in your environment.</li>
      <li>You need to be able to reliably trigger the problem.</li>
      <li>It helper if your commits are relatively small and if the system is in a loadable & executable state after each one.</li>
      </ul>
    </li>
    <li>If you specify a test by line number, be sure not to add lines to the file. Added lines could make it so you aren't running the test you think you're running.</li>
    <li><b>Rails is not your application</b>, it is a framework on which you build your application.</li>
    <li>If you have enough time to break focus while your tests run, you may not be getting the full value of the TDD process.</li>
    <li>By requiring the needed files instead of the `rails_helper`, you can bypass the loading of rails and isolate your tests to their precise needed data, thus speeding them up.</li>
    <li>The only way to know the boundaries of a new coding tool is to go past them. Try things.</li>
    <li>You can use doubles to remove test dependencies.</li>
    <li>You don't need to start with elaborate object indirection, but it's useful when logic gets complicated.</li>
    <li><b>When dealing with legacy code, respect code that works. You don't know what constraints the previous coders worked under.</b> Test the following.
      <ul>
        <li>Describe the current behavior</li>
        <li>Make sure code changes have no unintended consequences.</li>
        <li><b>Promote isolation of new features</b></li>
        <li>In the beginning, their might be a heightened use of mock objects, but over time the codebase & test coverage will improve.</li>
        <li>Do one thing at a time, to the extent possible.</li>
      </ul>
    </li>
    <li>When writing initial unit tests for legacy code, use the test to explore the code's behavior. Try to write a passing test without changing the code.
      <ul>
        <li>You might need to create objects and the chain can get unwieldy, it's okay: <b>the goal is to understand what's happening. If the code is unwieldy, let the test stand as a monument to things that need to be changed.</b></li>
      </ul>
    </li>
    <li>Dependency Removal - well done TDD forces individual pieces of the code to be as independent from each other as possible.
      <ul>
        <li>Where possible, write new code in new methods or new classes, and call them from the existing code.</li>
        <li>Keep an eye out for any added database constraints, such as foreign key constraints not specified in the code.</li>
        <li>Using mocks can allow you to temporarily put aside the rest of the application and focus on the single part you're trying to figure out.</li>
      </ul>
    </li>
  </ol>
