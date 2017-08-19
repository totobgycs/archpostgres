FROM totobgycs/archdev
MAINTAINER totobgycs

RUN useradd -m postgres
RUN echo "postgres ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN yaourt -Syy ; \
  yaourt -S --noconfirm postgresql 
  
USER postgres
WORKDIR /home/postgres
VOLUME [/var/lib/postgres/data]

COPY entry_point.sh entry_point.sh
RUN sudo chown postgres:postgres entry_point.sh ; \
  sudo chmod 700 entry_point.sh ; \ 
  sudo mkdir -p /var/run/postgresql ; \
  sudo chown postgres:postgres /var/run/postgresql ; \
  chmod 700 /var/run/postgresql ; \
  initdb -E UTF8 -D /var/lib/postgres/data ; \
  echo "#======================" >> /var/lib/postgres/data/postgresql.conf ; \
  echo "#   ontainer configs   " >> /var/lib/postgres/data/postgresql.conf ; \
  echo "#======================" >> /var/lib/postgres/data/postgresql.conf ; \
  echo "listen_addresses = '*'" >> /var/lib/postgres/data/postgresql.conf ;\
  echo "#======================" >> /var/lib/postgres/data/postgresql.conf ; \
  echo "#   ontainer configs   " >> /var/lib/postgres/data/pg_hba.conf ; \
  echo "#======================" >> /var/lib/postgres/data/pg_hba.conf ; \
  echo "host    all             postgres             0.0.0.0/0            reject" >> /var/lib/postgres/data/pg_hba.conf ; \
  echo "host    all             postgres             ::0/0                reject" >> /var/lib/postgres/data/pg_hba.conf ; \
  echo "host    all             all                  0.0.0.0/0            md5" >> /var/lib/postgres/data/pg_hba.conf ; \
  echo "host    all             all                  ::0/0                md5" >> /var/lib/postgres/data/pg_hba.conf 


  
EXPOSE 5432

ENV USERNAME=username
ENV PASSWORD=password

ENTRYPOINT ./entry_point.sh
