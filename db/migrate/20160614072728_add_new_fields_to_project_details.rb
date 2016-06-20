class AddNewFieldsToProjectDetails < ActiveRecord::Migration
  def up
  	execute <<-SQL
  	CREATE OR REPLACE VIEW "1".projects AS
    SELECT p.id AS project_id,
    p.category_id,
    p.name AS project_name,
    p.headline,
    p.permalink,
    p.mode,
    p.state::text,
    so.so AS state_order,
    od.od AS online_date,
    p.recommended,
    thumbnail_image(p.*, 'large'::text) AS project_img,
    remaining_time_json(p.*) AS remaining_time,
    p.expires_at,
    COALESCE(( SELECT
                CASE
                    WHEN p.state::text = 'failed'::text THEN pt.pledged
                    ELSE pt.paid_pledged
                END AS paid_pledged
           FROM "1".project_totals pt
          WHERE pt.project_id = p.id), 0::numeric) AS pledged,
    COALESCE(( SELECT pt.progress
           FROM "1".project_totals pt
          WHERE pt.project_id = p.id), 0::numeric) AS progress,
    s.acronym AS state_acronym,
    u.name AS owner_name,
    c.name AS city_name,
    p.full_text_index,
    is_current_and_online(p.expires_at, p.state::text) AS open_for_contributions,
    p.min_people,
    p.trip_end_date,
    p.max_people
   FROM projects p
     JOIN users u ON p.user_id = u.id
     JOIN cities c ON c.id = p.city_id
     JOIN states s ON s.id = c.state_id
     JOIN LATERAL zone_timestamp(online_at(p.*)) od(od) ON true
     JOIN LATERAL state_order(p.*) so(so) ON true;

    grant select on "1".projects to admin;
    grant select on "1".projects to web_user;
    grant select on "1".projects to anonymous;

    CREATE OR REPLACE VIEW "1".project_details AS
        SELECT p.id AS project_id,
        p.id,
        p.user_id,
        p.name,
        p.headline,
        p.budget,
        p.goal,
        p.about_html,
        p.permalink,
        p.video_embed_url,
        p.video_url,
        c.name_pt AS category_name,
        c.id AS category_id,
        original_image(p.*) AS original_image,
        thumbnail_image(p.*, 'thumb'::text) AS thumb_image,
        thumbnail_image(p.*, 'small'::text) AS small_image,
        thumbnail_image(p.*, 'large'::text) AS large_image,
        thumbnail_image(p.*, 'video_cover'::text) AS video_cover_image,
        COALESCE(pt.progress, 0::numeric) AS progress,
        COALESCE(
            CASE
                WHEN p.state::text = 'failed'::text THEN pt.pledged
                ELSE pt.paid_pledged
            END, 0::numeric) AS pledged,
        COALESCE(pt.total_contributions, 0::bigint) AS total_contributions,
        COALESCE(pt.total_contributors, 0::bigint) AS total_contributors,
        p.state::text AS state,
        mode(p.*) AS mode,
        state_order(p.*) AS state_order,
        p.expires_at,
        zone_timestamp(p.expires_at) AS zone_expires_at,
        online_at(p.*) AS online_date,
        zone_timestamp(online_at(p.*)) AS zone_online_date,
        zone_timestamp(in_analysis_at(p.*)) AS sent_to_analysis_at,
        is_published(p.*) AS is_published,
        is_expired(p.*) AS is_expired,
        open_for_contributions(p.*) AS open_for_contributions,
        p.online_days,
        remaining_time_json(p.*) AS remaining_time,
        elapsed_time_json(p.*) AS elapsed_time,
        ( SELECT count(pp_1.*) AS count
               FROM project_posts pp_1
              WHERE pp_1.project_id = p.id) AS posts_count,
        json_build_object('city', COALESCE(ct.name, u.address_city), 'state_acronym', COALESCE(st.acronym, u.address_state::character varying), 'state', COALESCE(st.name, u.address_state::character varying)) AS address,
        json_build_object('id', u.id, 'name', u.name) AS "user",
        count(DISTINCT pr.user_id) AS reminder_count,
        is_owner_or_admin(p.user_id) AS is_owner_or_admin,
        user_signed_in() AS user_signed_in,
        current_user_already_in_reminder(p.*) AS in_reminder,
        count(pp.*) AS total_posts,
        "current_user"() = 'admin'::name AS is_admin_role,
        p.min_people,
	    p.trip_end_date,
	    p.max_people
       FROM projects p
         JOIN categories c ON c.id = p.category_id
         JOIN users u ON u.id = p.user_id
         LEFT JOIN project_posts pp ON pp.project_id = p.id
         LEFT JOIN "1".project_totals pt ON pt.project_id = p.id
         LEFT JOIN cities ct ON ct.id = p.city_id
         LEFT JOIN states st ON st.id = ct.state_id
         LEFT JOIN project_reminders pr ON pr.project_id = p.id
      GROUP BY p.id, c.id, u.id, c.name_pt, ct.name, u.address_city, st.acronym, u.address_state, st.name, pt.progress, pt.pledged, pt.paid_pledged, pt.total_contributions, p.state, p.expires_at, pt.total_payment_service_fee, pt.total_contributors;

    grant select on "1".project_details to admin;
    grant select on "1".project_details to web_user;
    grant select on "1".project_details to anonymous;
    
    SQL
  end

  def down
  	execute <<-SQL
  	CREATE OR REPLACE VIEW "1".projects AS
    SELECT p.id AS project_id,
    p.category_id,
    p.name AS project_name,
    p.headline,
    p.permalink,
    p.mode,
    p.state::text,
    so.so AS state_order,
    od.od AS online_date,
    p.recommended,
    thumbnail_image(p.*, 'large'::text) AS project_img,
    remaining_time_json(p.*) AS remaining_time,
    p.expires_at,
    COALESCE(( SELECT
                CASE
                    WHEN p.state::text = 'failed'::text THEN pt.pledged
                    ELSE pt.paid_pledged
                END AS paid_pledged
           FROM "1".project_totals pt
          WHERE pt.project_id = p.id), 0::numeric) AS pledged,
    COALESCE(( SELECT pt.progress
           FROM "1".project_totals pt
          WHERE pt.project_id = p.id), 0::numeric) AS progress,
    s.acronym AS state_acronym,
    u.name AS owner_name,
    c.name AS city_name,
    p.full_text_index,
    is_current_and_online(p.expires_at, p.state::text) AS open_for_contributions
   FROM projects p
     JOIN users u ON p.user_id = u.id
     JOIN cities c ON c.id = p.city_id
     JOIN states s ON s.id = c.state_id
     JOIN LATERAL zone_timestamp(online_at(p.*)) od(od) ON true
     JOIN LATERAL state_order(p.*) so(so) ON true;

    grant select on "1".projects to admin;
    grant select on "1".projects to web_user;
    grant select on "1".projects to anonymous;

    CREATE OR REPLACE VIEW "1".project_details AS
        SELECT p.id AS project_id,
        p.id,
        p.user_id,
        p.name,
        p.headline,
        p.budget,
        p.goal,
        p.about_html,
        p.permalink,
        p.video_embed_url,
        p.video_url,
        c.name_pt AS category_name,
        c.id AS category_id,
        original_image(p.*) AS original_image,
        thumbnail_image(p.*, 'thumb'::text) AS thumb_image,
        thumbnail_image(p.*, 'small'::text) AS small_image,
        thumbnail_image(p.*, 'large'::text) AS large_image,
        thumbnail_image(p.*, 'video_cover'::text) AS video_cover_image,
        COALESCE(pt.progress, 0::numeric) AS progress,
        COALESCE(
            CASE
                WHEN p.state::text = 'failed'::text THEN pt.pledged
                ELSE pt.paid_pledged
            END, 0::numeric) AS pledged,
        COALESCE(pt.total_contributions, 0::bigint) AS total_contributions,
        COALESCE(pt.total_contributors, 0::bigint) AS total_contributors,
        p.state::text AS state,
        mode(p.*) AS mode,
        state_order(p.*) AS state_order,
        p.expires_at,
        zone_timestamp(p.expires_at) AS zone_expires_at,
        online_at(p.*) AS online_date,
        zone_timestamp(online_at(p.*)) AS zone_online_date,
        zone_timestamp(in_analysis_at(p.*)) AS sent_to_analysis_at,
        is_published(p.*) AS is_published,
        is_expired(p.*) AS is_expired,
        open_for_contributions(p.*) AS open_for_contributions,
        p.online_days,
        remaining_time_json(p.*) AS remaining_time,
        elapsed_time_json(p.*) AS elapsed_time,
        ( SELECT count(pp_1.*) AS count
               FROM project_posts pp_1
              WHERE pp_1.project_id = p.id) AS posts_count,
        json_build_object('city', COALESCE(ct.name, u.address_city), 'state_acronym', COALESCE(st.acronym, u.address_state::character varying), 'state', COALESCE(st.name, u.address_state::character varying)) AS address,
        json_build_object('id', u.id, 'name', u.name) AS "user",
        count(DISTINCT pr.user_id) AS reminder_count,
        is_owner_or_admin(p.user_id) AS is_owner_or_admin,
        user_signed_in() AS user_signed_in,
        current_user_already_in_reminder(p.*) AS in_reminder,
        count(pp.*) AS total_posts,
        "current_user"() = 'admin'::name AS is_admin_role
       FROM projects p
         JOIN categories c ON c.id = p.category_id
         JOIN users u ON u.id = p.user_id
         LEFT JOIN project_posts pp ON pp.project_id = p.id
         LEFT JOIN "1".project_totals pt ON pt.project_id = p.id
         LEFT JOIN cities ct ON ct.id = p.city_id
         LEFT JOIN states st ON st.id = ct.state_id
         LEFT JOIN project_reminders pr ON pr.project_id = p.id
      GROUP BY p.id, c.id, u.id, c.name_pt, ct.name, u.address_city, st.acronym, u.address_state, st.name, pt.progress, pt.pledged, pt.paid_pledged, pt.total_contributions, p.state, p.expires_at, pt.total_payment_service_fee, pt.total_contributors;

    grant select on "1".project_details to admin;
    grant select on "1".project_details to web_user;
    grant select on "1".project_details to anonymous;

    SQL
  end
end
