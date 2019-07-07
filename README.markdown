# Free-text Response XBlock
XBlock to capture a free-text response.

This package provides an XBlock for use with the EdX Platform and makes
it possible for instructors to create questions that expect a
free-text response.

Instructors define the following paramters in Studio:
- display name
- display correctness (True/False)
- Full-Credit Phrases (a list of phrases, of which, one must be present in the student's response in order to receive full-credit)
- Half-Credit Phrases (a list of phrases, of which, one must be present in the student's response in order to receive at least half-credit)
- Maximum Number of Attempts
- Maximum Word Count
- Minimum Word Count
- Prompt
- Question Weight

Students enter and submit their free-text responses, which instantly gets evaluated
according to the parameters above.

# Installation
- Add the xblock to your requirements/edx/github.text file
  e.g. -e git+https://github.com/Stanford-Online/xblock-free-text-response@cfb793db182b60281875b83b53a98640d740ebcf#egg=xblock-free-text-response

- In Studio Settings/Advanced Settings add the xblock to the Advanced Module List.
  e.g. "freetextresponse"

Now, when you create a component "Free-text Response" should appear in the Advanced Component List.


## Working with Translations

For information about working with translations, see the [Internationalization Support](http://edx.readthedocs.io/projects/xblock-tutorial/en/latest/edx_platform/edx_lms.html#internationalization-support) section of the [Open edX XBlock Tutorial](https://xblock-tutorial.readthedocs.io/en/latest/).

### Working with Transifex
Prepare your environment:

```
$ mkvirtualenv ftr-xblock
$ make requirements
```

Also ensure that the [Transifex client has the proper authentication](https://docs.transifex.com/client/init) 
in the `~/.transifexrc` file.

Push new strings to Transifex:
```
$ make push_translations
```

To get the latest translations from Transifex:
```
$ make pull_translations
```

For testing purposes it's faster to avoid Transifex and work on dummy Esperanto translations:
```
$ make build_dummy_translations
``` 
