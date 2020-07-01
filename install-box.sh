#!/bin/bash -e

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

# Install the docker-compose box to the current working directory
# Pre-requisites: git

echo "Cloning to current working directory from github..."
git init
# git remote add origin https://github.com/getumbrel/umbrel-compose.git
git remote add origin https://github.com/mayankchhabra/umbrel-compose.git
git fetch
# git reset origin/master
# git checkout -t origin/master
git reset origin/feature-ota
git checkout -t origin/feature-ota
git reset --hard

echo "Removing stuff we don't need"
rm -fr .git
rm -fr README.md
rm -fr LICENSE
rm -fr install-box.sh

echo "Installing complete"

