FROM solr:6.6.3-alpine

# Enviroment variables
ENV CKAN_VERSION 2.7.3
ENV SOLR_VERSION 6.6.3
ENV SOLR_CORE_EN ckan_en
ENV SOLR_CORE_TC ckan_tc
ENV SOLR_CORE_SC ckan_sc

# Create core directories
RUN mkdir -p /opt/solr/server/solr/$SOLR_CORE_EN/conf \
             /opt/solr/server/solr/$SOLR_CORE_EN/data \
             /opt/solr/server/solr/$SOLR_CORE_TC/conf \
             /opt/solr/server/solr/$SOLR_CORE_TC/data \
             /opt/solr/server/solr/$SOLR_CORE_SC/conf \
             /opt/solr/server/solr/$SOLR_CORE_SC/data

# Add files
ADD https://raw.githubusercontent.com/ckan/ckan/ckan-$CKAN_VERSION/contrib/docker/solr/solrconfig.xml \
    https://raw.githubusercontent.com/ckan/ckan/ckan-$CKAN_VERSION/ckan/config/solr/schema.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/currency.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/synonyms.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/stopwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/protwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/data_driven_schema_configs/conf/elevate.xml \
    /opt/solr/server/solr/$SOLR_CORE_EN/conf/
ADD https://raw.githubusercontent.com/ckan/ckan/ckan-$CKAN_VERSION/contrib/docker/solr/solrconfig.xml \
    https://raw.githubusercontent.com/ckan/ckan/ckan-$CKAN_VERSION/ckan/config/solr/schema.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/currency.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/synonyms.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/stopwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/protwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/data_driven_schema_configs/conf/elevate.xml \
    /opt/solr/server/solr/$SOLR_CORE_TC/conf/
ADD https://raw.githubusercontent.com/ckan/ckan/ckan-$CKAN_VERSION/contrib/docker/solr/solrconfig.xml \
    https://raw.githubusercontent.com/ckan/ckan/ckan-$CKAN_VERSION/ckan/config/solr/schema.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/currency.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/synonyms.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/stopwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/protwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/data_driven_schema_configs/conf/elevate.xml \
    /opt/solr/server/solr/$SOLR_CORE_SC/conf/

# Create core.properties
RUN echo name=$SOLR_CORE_EN > /opt/solr/server/solr/$SOLR_CORE_EN/core.properties
RUN echo name=$SOLR_CORE_TC > /opt/solr/server/solr/$SOLR_CORE_TC/core.properties
RUN echo name=$SOLR_CORE_SC > /opt/solr/server/solr/$SOLR_CORE_SC/core.properties

# Change ownership
USER root
RUN chown -R $SOLR_USER:$SOLR_USER /opt/solr/server/solr/$SOLR_CORE_EN \
                                   /opt/solr/server/solr/$SOLR_CORE_TC \
                                   /opt/solr/server/solr/$SOLR_CORE_SC

# User
USER $SOLR_USER:$SOLR_USER
