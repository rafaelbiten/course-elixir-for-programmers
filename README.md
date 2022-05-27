# Learning Elixir

## [COURSE] Elixir for Programmers
- [x] Go through the [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers-2) course.
- [x] Add the **Hangman** game core logic.
- [x] Work on different client implementations for the game.
- [x] Update this `README.md` file when done.

I'm leaving this Repo available mostly for my own reference.

### Folder Structure

The game and all of its different clients can be found inside the **hangman** root folder.

| Folder                                       | Contents                                                                                |
|:---------------------------------------------|:----------------------------------------------------------------------------------------|
| [client_cli](hangman/client_cli)             | A CLI client for the game                                                               |
| [client_html](hangman/client_html)           | An HTML client for the game                                                             |
| [client_live_view](hangman/client_live_view) | Similar to the HTML client, but using [Phoenix LiveView](https://phoenixframework.org/) |
| [dictionary](hangman/dictionary)             | An application to generate random words and a dependency for the hangman game           |
| [extras](hangman/extras)                     | Includes my solution for a fibonacci challenge present in the course                    |
| [hangman](hangman/hangman)                   | An application containing the core logic for the game                                   |
