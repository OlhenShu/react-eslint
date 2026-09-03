# Advanced Frontend with React.js

## The tasks of the topic "ESLint"

There is some project.

Install `eslint` as a development dependency and add an ESLint configuration file so that the following rules are reported as errors.

The configuration must parse modern JavaScript (`let`, `const`, arrow functions). Each example below shows only the rule it describes; follow all listed rules in your config. Formatting rules may use the core ESLint names or the equivalent `@stylistic/*` rules.

1. Enforce indent of 4 spaces

	_incorrect code for this rule_

	```js
	if (a) {
	 b = c;
	}
	```

	_correct code for this rule_

	```js
	if (a) {
	    b = c;
	}
	```

2. Require spaces around operators

	_incorrect code for this rule_

	```js
	a=b+c;
	```

	_correct code for this rule_

	```js
	a = b + c;
	```

3. Enforce the consistent use of single quotes

	_incorrect code for this rule_

	```js
	a = "double";
	```

	_correct code for this rule_

	```js
	a = 'single';
	```

4. Require `let` or `const` instead of `var`

	_incorrect code for this rule_

	```js
	var a = 0;
	```

	_correct code for this rule_

	```js
	let a = 0;
	```

5. Require `const` declarations for variables that are never reassigned after declared

	_incorrect code for this rule_

	```js
	let a = 'initialized and never reassigned';
	```

	_correct code for this rule_

	```js
	const a = 'initialized and never reassigned';
	```

6. Enforce the use of `===` and `!==`

	_incorrect code for this rule_

	```js
	a == b;
	```

	_correct code for this rule_

	```js
	a === b;
	```

7. Disallow the use of `console`

	_incorrect code for this rule_

	```js
	console.log('Some message');
	```

	_correct code for this rule_

	```js
	const message = 'Some message';
	```

8. Disallow assignment operators in conditional expressions

	_incorrect code for this rule_

	```js
	if (a = 0) {
	    b = c;
	}
	```

	_correct code for this rule_

	```js
	if (a === 0) {
	    b = c;
	}
	```

9. Disallow unnecessary semicolons

	_incorrect code for this rule_

	```js
	a = b;;
	```

	_correct code for this rule_

	```js
	a = b;
	```

10. Disallow comments on the same line as code

	_incorrect code for this rule_

	```js
	a = 1; // a to 1
	```

	_correct code for this rule_

	```js
	// a to 1
	a = 1;
	```

11. Disallow `else` blocks after `return` statements in `if` statements

	_incorrect code for this rule_

	```js
	function demo() {
	    if (a) {
	        return b;
	    } else {
	        return c;
	    }
	}
	```

	_correct code for this rule_

	```js
	function demo() {
	    if (a) {
	        return b;
	    }
	    return c;
	}
	```

12. Require curly braces for all control statements

	_incorrect code for this rule_

	```js
	if (a === 0) a += 2;
	```

	_correct code for this rule_

	```js
	if (a === 0) {
	    a += 2;
	}
	```
