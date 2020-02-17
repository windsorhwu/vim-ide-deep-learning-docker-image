# Deep Learning with PyTorch and a Vim IDE

## Installation Instructions
1.  Add a copy of your TabNine configuration folder into this directory (on Linux this is ~/.config/TabNine).
2. Build the image:
```bash
docker build .
```
3. Run the image in interactive mode:
```bash
docker run -it --gpus all <image-id>
```

## Details
This image is based on NVIDIA's [PyTorch image](https://ngc.nvidia.com/catalog/containers/nvidia:pytorch) and includes CUDA 10 and associated optimization libraries, Anaconda with the SciPy stack, and of course PyTorch. Also included are some useful Python libraries:
*  ax-platform for Bayesian optimization.
*  ray for distributed hyperparameter tuning and logging.
*  mlflow for experiment tracking (integrates easily with ray).
*  dask for distributed data wrangling.
*  awscli and boto3 for AWS.
*  tqdm for progress bars.
*  black for formatting.

The Vim IDE includes nerdtree for file browsing, PEP 8 formatting, code folding, ctags for searching, TabNine for AI powered code completion, and solarized as the theme.

I built this image to provide a full featured IDE capable of running via ssh. The original intention was to replace PyCharm and the remote deploy feature, but now I like it better thanks to the total removal of the mouse. Check out vast.ai for a cheap peer-to-peer cloud option that runs the Docker image you specify.

## Useful Commands
When in Vim:
*  C(control)-n opens the nerdtree file browser.
*  When the cursor is on a Python function, C-W ] splits the window and opens the source file.
*  F5 toggles the dark and light solarized themes.
*  Tab completes the suggestion.
