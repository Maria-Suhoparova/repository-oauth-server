DROP TABLE IF EXISTS oauth_client_details;
DROP TABLE IF EXISTS permission CASCADE;
DROP TABLE IF EXISTS role CASCADE ;
DROP TABLE IF EXISTS users CASCADE ;
DROP TABLE IF EXISTS permission_role CASCADE ;
DROP TABLE IF EXISTS role_user CASCADE ;
DROP TABLE IF EXISTS oauth_client_token CASCADE ;
DROP TABLE IF EXISTS oauth_refresh_token CASCADE ;
DROP TABLE IF EXISTS oauth_code CASCADE ;
DROP TABLE IF EXISTS oauth_approvals CASCADE;

create table if not exists  oauth_client_details (
                                                     client_id varchar(255) not null,
                                                     client_secret varchar(255) not null,
                                                     web_server_redirect_uri varchar(2048) default null,
                                                     scope varchar(255) default null,
                                                     access_token_validity integer default null,
                                                     refresh_token_validity integer default null,
                                                     resource_ids varchar(1024) default null,
                                                     authorized_grant_types varchar(1024) default null,
                                                     authorities varchar(1024) default null,
                                                     additional_information varchar(4096) default null,
                                                     autoapprove varchar(255) default null,
                                                     primary key (client_id)
);

create table if not exists  permission (
                                           id SERIAL,
                                           name varchar(512) default null UNIQUE ,
                                           primary key (id)
);

create table if not exists role (
                                    id SERIAL,
                                    name varchar(255) default null UNIQUE ,
                                    primary key (id)
);

create table if not exists   users (
                                     id SERIAL,
                                     username varchar(100) not null UNIQUE ,
                                     password varchar(1024) not null,
                                     email varchar(1024) not null,
                                     enabled SMALLINT not null,
                                     accountNonExpired SMALLINT not null,
                                     credentialsNonExpired SMALLINT not null,
                                     accountNonLocked SMALLINT not null,
                                     primary key (id)
);


create table  if not exists permission_role (
                                                permission_id integer default null,
                                                role_id integer default null,
                                                constraint permission_role_ibfk_1 foreign key (permission_id) references permission (id),
                                                constraint permission_role_ibfk_2 foreign key (role_id) references role (id)
);



create table if not exists role_user (
                                         role_id integer default null,
                                         user_id integer default null,
                                         constraint role_user_ibfk_1 foreign key (role_id) references role (id),
                                         constraint role_user_ibfk_2 foreign key (user_id) references users (id)
);

-- token store
create table if not exists oauth_client_token (
                                                  token_id VARCHAR(256),
                                                  token bytea,
                                                  authentication_id VARCHAR(256) PRIMARY KEY,
                                                  user_name VARCHAR(256),
                                                  client_id VARCHAR(256)
);

create table if not exists oauth_access_token (
                                                  token_id VARCHAR(256),
                                                  token bytea,
                                                  authentication_id VARCHAR(256) PRIMARY KEY,
                                                  user_name VARCHAR(256),
                                                  client_id VARCHAR(256),
                                                  authentication bytea,
                                                  refresh_token VARCHAR(256)
);

create table if not exists oauth_refresh_token (
                                                   token_id VARCHAR(256),
                                                   token bytea,
                                                   authentication bytea
);

create table if not exists oauth_code (
                                          code VARCHAR(256),
                                          authentication bytea
);

create table if not exists oauth_approvals (
                                               userId VARCHAR(256),
                                               clientId VARCHAR(256),
                                               scope VARCHAR(256),
                                               status VARCHAR(10),
                                               expiresAt TIMESTAMP,
                                               lastModifiedAt TIMESTAMP
);

