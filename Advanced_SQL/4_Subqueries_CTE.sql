/*
Find the count of the number of remote job postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skill)
*/

WITH remote_job_skills AS (
	SELECT
		sjd.skill_id,
		sd.skills,
		sjd.job_id
	FROM job_postings_fact AS jpf
	INNER JOIN skills_job_dim AS sjd
		ON jpf.job_id = sjd.job_id
	INNER JOIN skills_dim AS sd
		ON sjd.skill_id = sd.skill_id
	WHERE jpf.job_work_from_home = TRUE AND jpf.job_title_short = 'Data Analyst'
)
SELECT
	skill_id,
	skills,
	COUNT(DISTINCT job_id) AS remote_job_count
FROM remote_job_skills
GROUP BY skill_id, skills
ORDER BY remote_job_count DESC
LIMIT 5;