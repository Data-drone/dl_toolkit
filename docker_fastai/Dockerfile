FROM datadrone/deeplearn_minimal

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

RUN conda install -c numpy scipy matplotlib scikit-image scikit-learn pandas seaborn

RUN conda install -c pytorch pytorch-nightly cuda92
RUN conda install -c fastai torchvision-nightly
RUN conda install -c fastai fastai
