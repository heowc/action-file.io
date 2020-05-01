![Test](https://github.com/heowc/action-file.io/workflows/Test/badge.svg?branch=master)

# GitHub Action for [`file.io`](https://file.io)

This action upload compression file(s) to `file.io`

## Inputs

### `position`

Base location for finding file. Default `"."`.

### `file_basename`

File name to be created. Default `"file"`.

### `file_path`

**Required** Path of the file(s) to upload.

### `expires`

How long files are not deleted. (See https://www.file.io/)

## Outputs

### `response`

Response for curl

## Example usage

[link](.github/workflows/test.yml)