## makeR

Makefile and tools for R packages

This is a git submodule we include in our R packages to have a Makefile and some tools for package building, testing and documentation generation. Including this as a submodule in other projects enables us to hold the code for this in one central place (i.e., here) without copy-paste horror. 

The submodule is always included under the path 'makeR' in the respective package repositories, e.g., look here:
https://github.com/berndbischl/BBmisc

### Upgrading

The installation method has switched from submodules to subtrees. To upgrade an existing submodule-based installation, please run `make uninistall` first; you may also want to remove the `.gitmodules` file if you do not use other submodules. After switching, you can run `make upgrade` as usual for further upgrades.


### Installing the subtree

Execute the following in a terminal:

```
curl http://krlmlr.github.io/makeR/install2 | sh
```

Take a look at [the installer script](https://github.com/krlmlr/makeR/blob/gh-pages/install2) if you're curious.


### Updating makeR

If you want to update the makeR tool chain, run: 

```
make upgrade
```




