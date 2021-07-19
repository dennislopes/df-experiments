# df-experiments

git clone https://github.com/dennislopes/df-experiments.git

cd df-experiments/dockerfile/

docker build -t df-experiments .

cd ../

docker container run -ti -v ~/df-experiments/results:/PPgSI/results  -v ~/df-experiments/workdir:/PPgSI/workdir df-

experiments
