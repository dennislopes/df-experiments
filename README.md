# df-experiments

git clone https://github.com/dennislopes/df-experiments.git

cd df-experiments/dockerfile/

docker build -t df-experiments .

cd ../

docker container run -ti -v ~/df-experiments/results:/PPgSI/results  -v ~/df-experiments/workdir:/PPgSI/workdir df-experiments

java -cp .:/PPgSI/workdir/lib/junit-4.13.2.jar:/PPgSI/workdir/lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore <tests>
