ARG DEBIAN_FRONTEND=noninteractive

FROM ubuntu:20.04

ENV TZ=America/New_York
 
RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y nmap net-tools openssl openssh-server \
  && apt-get install -y git wget curl vim \
  && apt-get install -y tzdata zsh

RUN apt-get install -y build-essential checkinstall libssl-dev
RUN sh -c "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash"

#RUN sh -c "groupadd --gid 1000 jpbutler && useradd --uid 1000 --gid jpbutler --shell /usr/bin/zsh --create-home jpbutler"

WORKDIR /etc/ssl

COPY ./etc/ssl .

WORKDIR /root

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git config --global http.sslverify true && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

COPY ./shell .

CMD ["/usr/bin/zsh"]