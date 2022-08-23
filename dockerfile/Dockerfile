FROM openjdk:8

RUN echo 'alias la="ls -lha"' >> ~/.bashrc

RUN apt-get update && \
        apt-get install -y sloccount && \
	apt-get install -y python3-pip python3-dev && \
	apt-get install -y python3-venv && \
	apt-get install -y python3-numpy && \
	apt-get install -y maven && \
	apt-get install -y build-essential && \
	apt-get install -y libxml2-utils && \
    curl -L https://cpanmin.us | perl - App::cpanminus

RUN pip3 install --upgrade pip
RUN python3 -m venv /opt/venv
RUN . /opt/venv/bin/activate && pip3 install jupyter

WORKDIR /PPgSI

# install defects4j
RUN git clone https://github.com/rjust/defects4j.git
WORKDIR /PPgSI/defects4j
RUN cpanm --installdeps . && \
	./init.sh
ENV PATH="${PATH}:/PPgSI/defects4j/framework/bin"

WORKDIR /PPgSI

# install ba-dua
RUN git clone https://github.com/saeg/ba-dua.git
WORKDIR /PPgSI/ba-dua
RUN git checkout 60983f5 && \
	mvn clean install

WORKDIR /PPgSI

# install jaguar-df
RUN git clone https://github.com/marioconcilio/jaguar-df.git
WORKDIR /PPgSI/jaguar-df
RUN mvn clean install

WORKDIR /PPgSI
RUN apt install vim -y
RUN git clone https://github.com/dennislopes/df-experiments.git
WORKDIR /PPgSI/df-experiments
RUN chmod +x *.sh
