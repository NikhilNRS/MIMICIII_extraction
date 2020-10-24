# MIMICIII_extraction

Although MIMIC-III is an open database, it cannot be directly downloaded from a URL. The
steps to obtain access to MIMIC-III are described in-detail on the "Requesting access" page in
the official MIMIC-III documentation. In brief, one first has to complete the CITI "Data or
Specimens Only Research" online course, which mainly serves the purpose of informing the user
of the conditions for using MIMIC-III (e.g. one should not attempt to identify any individual in
the dataset). Consequently, access can be requested to the dataset, which involves providing a
description with the reason for access, obtaining a validation of your request by your supervisor
(he or she is sent an e-mail with a link to validate your request), and getting consent from the
managers of the PhysioNet platform. Afterwards, compressed versions of the tables in the database
can be downloaded on the MIMIC-III page (an individual .csv.gz file for each table). Note that
the compressed tables take approximately 6.2GB of disk space.

To access the tables conveniently without having to load them fully into RAM, the official MIMICIII
documentation provides a description of how to build a PostgreSQL database of MIMIC-III
on your local machine, both for Windows and Unix/Mac. These pages delineate the various
commands that have to be run in order to build the database. To sum up some additional
relevant details:

* Code was was executed on a Windows machine with an Intel i7-8705G CPU, 8GB RAM
and a PM981 NVMe Samsung 512GB SSD.
* To solve some errors that occurred when running the commands to build the PostgreSQ
database, we had to untick the box "Beta: Use Unicode UTF-8 for worldwide language
support" in Control Panel - Clock and Region - Region - Administrative - Change system
locale.
* Filepaths in the PostgreSQL shell (PSQL) must be specified with forward path slashes and
surrounded by single quotes.
* As the process of building the database seemed to freeze with the compressed tables on our
machine (.csv.gz files), we built the database using the extracted tables (.csv files). Keep in
mind that the extracted tables take 43GB of disk space, and that the PostgreSQL database
of these files takes an additional 62GB including table indexes. This means that you will
need at least 105GB of disk space to prepare the MIMIC-III database for use.
* Loading the (uncompressed) tables into the database took approximately
3 hours, while building the indexes (for faster query performance) took approximately 15
minutes.

As described on the page of the Windows tutorial, running SQL queries on MIMIC-III in the PSQL
shell always requires one to run "nc mimic;" and "set search path to mimiciii;" at the start of the
session in order to query the tables in the PostgreSQL database. Before running these prompts,
the PSQL shell asks the user to specify a server, database, port, username and password. For the
first 4, the user can just hit enter without typing anything, while the password needs to typed
in manually before hitting enter. Note that the window stays black while typing the password
(i.e. the user does not see whether the typing actually happens), but the user needs to type the
password anyway and then hit enter.


## Implementation

As emphasized by Johnson, Pollard & Mark (2017), reproducibility and reusability in machine
learning research within the healthcare domain is extremely beneficial for reproducibility and
building future works on top of a earlier works. Following the philosophy of Papers With Code,
which are now also the official guidelines for NeurIPS 2020, we provide elaborate materials for
reproducing this research and building on top of it in future works. In the supplementary folder
to this thesis, you will find the following materials:

* 11 ordered Jupyter notebooks containing the actual implementation of the analyses with
extensive comments, documentation and explanations. All lines that write files to disk are
commented out for safety - this avoids you from directly overwriting files if you re-execute the
notebooks. In notebook cells that took more than a few minutes to run, we put a comment
that indicates how long the code ran on our machine as an indication.
* Note that the files of the MIMIC-III database itself are not included here,
as access to the raw data must be acquired through the official access requesting process.
* A folder named "queries", with two SQL queries that generate materialized views (processed
datasets) on the MIMIC-III database for processing data out-of-memory. One of these
("Explicit sepsis.sql") originates from the official MIMIC code repository (Johnson, Stone
et al., 2017).
* A folder named "modules" containing re-usable Python modules with functionality
used across the Jupyter notebooks.
