# Trinitycore 6.x using Docker-Compose

This repository is not an official one by the Trinitycore-Devs, but I tried to make it as simple and efficient as I could. It is possible to run Trinitycore with this approach very easily, while still containing the flexibility to change anything you want.

## Prequisites

You will need:

* [Docker](https://www.docker.com/products/docker)
* [Docker-Compose](https://docs.docker.com/compose/install/)
* Your copy of WoW **OR** already extracted maps/vmaps/etc.

## Usage

### Config

If you just want to get the server up and running, you don't need to change anything (maybe the locale, if your game is not in english).

If you want to make the server public, you can change the mysql-password in the `docker-compose.yml`.

Any other changes can be made directly in the config files under trinitycore/config/etc.

### Building/Compiling
First, you need to build the images by simply doing a

```docker-compose build```

in the folder where you cloned/downloaded this repo. This will build two docker images, `tc_db` and `trinitycore`. **Warning:** This will compile the Trinitycore binaries, so it could take a while.

*Hint: If you want to update Trinitycore, just append `--no-cache` and run the above command again. This will download and compile the sources again*

### Extracting

If you didn't download or extract the needed maps yet, you can get them by placing/copying (or linking under linux) your game folder's *content* into the trinitycore/game folder of this repository and then running

```docker-compose run trinitycore ./extract.sh```

to extract them. **Warning:** This will probably take some time (and space).

### Starting the servers

When you have the maps in the given folders, you can start everything with

```docker-compose up```

If you want to let it run in the background, just append `-d` to the command.

That's it! Trinitycore should be up and running now.

### Sending input to the worldserver

In some cases (creating an account, for example) you will need to send some input to the running `worldserver`. Because it runs inside a docker-container, this can get a little tricky. Luckily I had the same problem and came up with a rather simple solution: The process reads input from a file!

```docker exec -ti trinitycore echo 'help' >> world.input```

The above command will just append a line with the content 'help' into `world.input` inside the container. The worldserver process will then read and interpret it.

