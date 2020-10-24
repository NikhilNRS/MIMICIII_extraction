/*
	This script generates materialized views for the chartevents, 
	labevents and microbiologyevents tables such that they only contain 
	events corresponding to hospital admissions that eventually included a septic
	shock diagnosis. This is required to narrow down the huge events tables
	and thereby speeding up later preprocessing of this data.

	Dependency tables
	-----
	explicit_sepsis

*/
--Chartevents septic shock-only materialized view. Runs in ~2 mins.
create materialized view chartevents_ss AS
with sep_shock_pats as (
    select subject_id, hadm_id
    from explicit_sepsis
    where septic_shock = 1
)
(
	SELECT c.*
	FROM chartevents as c
	INNER JOIN sep_shock_pats as s
		ON c.subject_id = s.subject_id AND c.hadm_id = s.hadm_id
);

--Labevents septic shock-only materialized view. Runs in ~20 sec.
create materialized view labevents_ss AS
with sep_shock_pats as (
    select subject_id, hadm_id
    from explicit_sepsis
    where septic_shock = 1
)
(
	SELECT l.*
	FROM labevents as l
	INNER JOIN sep_shock_pats as s
		ON l.subject_id = s.subject_id AND l.hadm_id = s.hadm_id
);


--Micriobiologyevents septic shock-only materialized view. Runs near-instantly.
--Might be needed in the future
create materialized view microbiologyevents_ss AS
with sep_shock_pats as (
    select subject_id, hadm_id
    from explicit_sepsis
    where septic_shock = 1
)
(
	SELECT m.*
	FROM microbiologyevents as m
	INNER JOIN sep_shock_pats as s
		ON m.subject_id = s.subject_id AND m.hadm_id = s.hadm_id
);