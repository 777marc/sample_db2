FROM icr.io/db2_community/db2

ENV LICENSE=accept
ENV DB2INSTANCE=db2inst1
ENV DB2INST1_PASSWORD=db2inst1
ENV DBNAME=testdb

# Copy the initialization scripts
COPY init-db.sh /var/custom/init-db.sh
COPY create-table.sql /var/custom/create-table.sql
COPY seed-data.sql /var/custom/seed-data.sql

# Make the init script executable
RUN chmod +x /var/custom/init-db.sh

# Expose DB2 port
EXPOSE 50000

# Set the entrypoint to run the custom init script
CMD ["/var/custom/init-db.sh"]
