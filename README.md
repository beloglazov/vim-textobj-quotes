# vim-textobj-quotes

`vim-textobj-quotes` is a Vim plugin providing text objects for the closest
pairs of quotes of any type. Using only `iq` or `aq` it allows you to operate on
content of single ('), double ("), or back (`) quotes that currently surround
the cursor, are in front of the cursor, or behind (in that order of preference).
In other words, it jumps forward or backwards when needed to reach the quotes.

It's easier to understand by looking at examples (the cursor is shown with `|`):

1. Before: `foo '1, |2, 3' bar`; after pressing `diq`: `foo '|' bar`
2. Before: `foo| '1, 2, 3' bar`; after pressing `diq`: `foo '|' bar`
3. Before: `foo '1, 2, 3' |bar`; after pressing `diq`: `foo '|' bar`
4. Before: `foo '1, |2, 3' bar`; after pressing `daq`: `foo | bar`
5. Before: `foo| '1, 2, 3' bar`; after pressing `daq`: `foo | bar`
6. Before: `foo '1, 2, 3' |bar`; after pressing `daq`: `foo | bar`

The examples above are given for single quotes, the plugin works exactly the
same way for double (") and back (`) quotes.


## Installation

This plugin requires
[vim-textobj-user](https://github.com/kana/vim-textobj-user) to be installed. If
you are using Vundle, just add the following lines to your .vimrc:

```
Bundle 'kana/vim-textobj-user'
Bundle 'beloglazov/vim-textobj-quotes'
```

Then run `:BundleInstall` to install the plugins.


## Configuration

As most of the time, you need to operate on a text inside quotes, I add the
following binding to make it even more convenient to use:

```
xmap q iq
omap q iq
```

Now, you just need to press `cq`, `dq`, `yq`, or `vq` to operate on the text in
single ('), double ("), or back (`) quotes nearby without manually moving into
them.


Enjoy! :)


## License

Copyright (c) Anton Beloglazov. Distributed under the same terms as Vim itself.
See :help license.
