# ESLint: Fix Issues, Don't Bypass

## Rule

When ESLint reports unused variables or other errors, **fix the code properly** instead of adding `// eslint-disable-next-line` comments.

## Examples

### Bad: Bypassing with comment

```javascript
// eslint-disable-next-line no-unused-vars
const { onChange, value, ...restProps } = props;

// eslint-disable-next-line no-unused-vars
element.setSelectionRange = (start, end) => {
  setCaretPosition(element, start);
};
```

### Good: Actually fixing the issue

```javascript
// Remove unused variable from destructuring, delete it separately
const { onChange, ...restProps } = props;
delete restProps.value;

// Remove unused parameter
element.setSelectionRange = start => {
  setCaretPosition(element, start);
};
```

## Why

- Bypass comments hide real issues
- They make code harder to maintain
- They set a bad precedent for the codebase
- The actual fix is usually simple
