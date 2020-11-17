# Deep Learning with PyTorch and a Vim Based IDE

## Installation Instructions
0. Build and tag the deep learning image.
```bash
git clone https://github.com/vim-ide-deep-learning-docker-image
cd vim-ide-deep-learning-docker-image/deep-learning
docker build -t deep-learning .
cd ..
```
1.  (Optional, allows TabNine to use your settings and deep learning model) Clone this repository and add a copy of your TabNine configuration folder into this directory (on Linux this is ~/.config/TabNine). If you do not have TabNine (consider rectifying this unfortunate reality) comment out the TabNine configuration in the vim-ide Docker file.
```bash
cp -R ~/.config/TabNine deep-learning-docker/TabNine .
cp ~/.local/share/TabNine/models/model-name .
```
2. Build the vim-ide image using the deep-learning image as the base:
```bash
cd vim-ide
docker build -t vim-ide .
```
3. Run the image in interactive mode:
```bash
docker run -it --gpus all vim-ide
```

## Details
The deep-learning image is based on NVIDIA's [PyTorch image](https://ngc.nvidia.com/catalog/containers/nvidia:pytorch) and includes CUDA 10 and associated optimization libraries, Anaconda with the SciPy stack, and of course PyTorch. Also included are some useful Python libraries:
*  ax-platform for Bayesian optimization.
*  ray for distributed hyperparameter tuning and logging.
*  mlflow for experiment tracking (integrates easily with ray).
*  dask for distributed data wrangling.
*  awscli and boto3 for AWS.
*  tqdm for progress bars.

The Vim image includes a full featureed IDE with nerdtree for file browsing, PEP 8 formatting, code folding, ctags for searching, TabNine for AI powered code completion, solarized as the theme, and syntastic for catching silly bugs (I disable warnings). Also:
*  black for formatting.
*  flake8 with black compatability.

I built this image to provide a full featured IDE capable of running via ssh. The original intention was to replace PyCharm and the remote deploy feature, but now I like it better thanks to the total removal of the mouse. Check out [vast.ai](vast.ai) for a cheap peer-to-peer cloud option that runs the Docker image you specify.

## Useful Commands in Vim
*  C(control)-n opens the nerdtree file browser.
*  When the cursor is on a Python function, C-W  ] splits the window and opens the source file.
*  F5 toggles the dark and light solarized themes.
*  Tab completes suggestions.
