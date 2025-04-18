# Environment Configs

You can place your custom configuration files inside the appropriate subdirectories based on the desktop environment.

Make a directory for your environment config and create a `setup.sh` file inside it.  
The `setup.sh` script should handle applying or copying the configuration files.

### Example Directory Structure:

| Environment   | Directory     | Script    |
| ------------- | ------------- | --------- |
| KDE           | `KDE/mohamed/`| `setup.sh`|
| XFCE          | `XFCE/emadadel/`| `setup.sh`|
| Your custom environment | `your_env/` | `setup.sh`|