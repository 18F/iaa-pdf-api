# iaa-pdf-api

A lightweight server for the [IAA gem](https://github.com/18f/iaa-gem). This server provides a RESTful interface to generating interagency agreement PDFs.

## Usage

The IAA gem requires `pdftk`. Ensure you have that before proceeding.

Clone the repo, `cd` into it, and run `bundle`.

Start the server:

```bash
bundle exec thin start -p 4000
```
