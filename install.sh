# CLOUD SETUP
sudo apt update
sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev # required by pyenv
sudo apt install gcc g++ gfortran python3-dev libopenblas-dev liblapack-dev cython # required by scipy
sudo apt install python3-venv # required by poetry
sudo apt install libgeos++-dev libproj-dev # required by cartopy

curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

curl -sSL https://install.python-poetry.org | python3 -
echo "export PATH="/home/$USER/.local/bin:\$PATH"" >> ~/.bashrc
source ~/.bashrc
# poetry config virtualenvs.prefer-active-python true

# INSTALL PYTHON3.7
pyenv install 3.7.7

# UPLOAD CPLEX STUDIO (from local machine)
# scp -C cplex_studio2210.linux_x86_64.bin gcp:~

# INSTALL CPLEX
./cplex_studio2210.linux_x86_64.bin
python3.7 /opt/ibm/ILOG/CPLEX_Studio221/python/setup.py build -b "/home/patryk" install --home "/home/patryk/cplex" --no-deps
echo 'export PYTHONPATH="/home/patryk/cplex/lib/python/:$PYTHONPATH"' >> ~/.bashrc

# CLONE PYPSA-PL AND SETUP POETRY
git clone https://github.com/patryk-kubiczek/pypsa-pl.git
cd pypsa-pl
pyenv local 3.7.7
poetry env use python3.7
poetry install

