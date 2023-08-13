`translations_manager`

## Introduction

`translations_manager` is a powerful Dart tool designed to manage and inspect JSON translation files, such as `en_US.json`. With the capability to scrutinize both Dart files and translations, this tool helps in keeping your translations efficient and free from clutter.

## Installation

(TODO: Provide installation steps here. Typically, instructions for adding the package to the `pubspec.yaml` file, and running `pub get`, are provided.)

## Basic Command

To use the `translations_manager`, you need to invoke the Dart runtime followed by the `translations_manager` command:
dart run translations_manager



## Available Tasks

### 1. Find Missing Translations in Dart Files

This task searches through all `.dart` files in the project to check which translation terms are used but have not been added to the translation files. This ensures that every translation string used in the codebase has an appropriate entry in the translation files.

**Command**:
dart run translations_manager find-missing-terms [options]

#### Options

- `--output-path` OR `-o`: Set the path where the file containing missing translations will be saved.

- `--export` OR `-e`: Decide whether or not to save the missing translations. If not provided, missing translations won't be saved.


#### Example Usage

List all missing terms and save them to a specific file:
dart run translations_manager find-missing-terms -o /path/to/save/missing_terms.json -e

### 2. Listing Unused Terms

This task inspects all your translations files in tandem with the Dart files to list out all unused translations.

**Command**:
dart run translations_manager list-unused-terms [options]

#### Options

- `--output-path` OR `-o`: Set the path where the file containing unused translations will be saved.

- `--export` OR `-e`: Decide whether or not to save the unused translations. If not provided, unused translations won't be saved.

- `--abort-on-unused` OR `-a`: Abort execution if any unused translations are found.

#### Example Usage

List all unused terms and save them to a specific file:
dart run translations_manager list-unused-terms -o /path/to/save/unused_terms.json -e


Abort the command if any unused translations are detected:
dart run translations_manager list-unused-terms -a


### 3. Clean Unused Translations

This task removes all unused translations from your files, ensuring they are as lean as possible.

**Command**:
dart run translations_manager clean-translations [options]


#### Options

- `--output-path` OR `-o`: Set the path where the file containing cleaned translations will be saved.

- `--export` OR `-e`: Decide whether or not to save the cleaned translations to the specified output path. If not provided, cleaned translations won't be saved.

#### Example Usage

Clean all unused translations and save the result to a specific file:
dart run translations_manager clean-translations -o /path/to/save/cleaned_translations.json -e


Simply clean the translations without saving:
dart run translations_manager clean-translations

### 4. Compare Translations

This task is designed to compare your translation files with each other, pinpointing any missing terms to ensure consistency across different languages.

**Command**:
dart run translations_manager compare-translation

### 5. Configure Translate API

This task lets you set up your Google Translate API key by adding it to the `.env` file. This API key will then be utilized when adding translations.

**Command**:
dart run translations_manager configure-translate-api [YOUR_API_KEY]

### 6. Add Translation

This task allows you to translate a specific term into supported languages and then add the newly translated terms directly to the translation files.

**Command**:
dart run translations_manager add-translation [TERM]


Upon executing this command, the translated term will be displayed. To save the translated term to the translation files, simply answer 'yes' when prompted.

#### Example Usage

Translate the term "hello" and get a prompt to save the translation:
dart run translations_manager add-translation hello


(Note: Ensure you have previously configured the Translate API key using the `configure-translate-api` command for this functionality to work seamlessly.)

(TODO: Provide any additional details about the supported languages, how the translations are fetched, or other specifics related to this command. Continue with other tasks, how to contribute, version history, etc., if necessary.)

### 7. Sort Translations

This task sorts all the translations in your translation files in alphabetical order.

**Command**:
dart run translations_manager sort-translations


