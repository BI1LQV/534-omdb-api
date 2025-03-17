# Code of Conduct for Development Team

## Technical Requirements and Best Practices

### Documentation Standards
- Every function must include comprehensive documentation
- Documentation should clearly describe:
  - Function purpose
  - Input parameters and their types
  - Return values
  - Usage examples where appropriate

### Testing Requirements
1. Unit Tests
   - All new code must be accompanied by unit tests
   - Tests should be placed in the `tests/` directory
   - Tests must cover all code paths and edge cases
   - Test names should clearly describe the scenario being tested

2. Test Execution
   - Run `scripts/test.r` to verify all unit tests pass
   - All tests must pass before submitting code for review
   - Fix any failing tests before proceeding with commits

### Build Process
- Before committing changes:
  1. Run `scripts/build.r` to compile and verify package functionality
  2. Address any build errors or warnings
  3. Ensure the package builds successfully

## Team Interaction Guidelines

### Code Review Process
- Be respectful and constructive when providing feedback
- Focus on the code, not the person
- Explain your reasoning when requesting changes
- Acknowledge and appreciate others' contributions

### Communication
- Maintain professional and inclusive language
- Be open to questions and discussions
- Share knowledge and help team members learn
- Respond to queries in a timely manner

### Collaboration
- Be open to feedback and suggestions
- Work together to solve problems
- Share improvements and optimizations
- Support team members in maintaining code quality

## Compliance

Team members are expected to follow these guidelines to maintain code quality and foster a positive development environment. Repeated failure to meet these standards will be addressed by team leads.

## Questions and Updates

If you have questions about these guidelines or suggestions for improvements, please discuss with the team lead or raise them during team meetings. 