# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160213145329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_account_activities", force: :cascade do |t|
    t.integer "admin_id",           default: 0,    null: false
    t.boolean "agent_branding",     default: true
    t.boolean "display_contents",   default: true
    t.boolean "restriction_option", default: true
    t.boolean "data_log",           default: true
    t.boolean "statistic",          default: true
    t.boolean "tour_branding",      default: true
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "super",                  default: false
    t.string   "username",               default: "",    null: false
    t.string   "first_name",             default: "",    null: false
    t.string   "last_name",              default: "",    null: false
    t.integer  "agent_type",             default: 2,     null: false
    t.float    "latitude",               default: 0.0
    t.float    "longitude",              default: 0.0
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "agent_brandings", force: :cascade do |t|
    t.string   "tour_id"
    t.string   "avatar"
    t.string   "branded_url"
    t.string   "embed_code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "agent_infos", force: :cascade do |t|
    t.string   "mobile_phone"
    t.string   "avatar"
    t.boolean  "is_show_agent_branding"
    t.text     "tooltip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "office_phone"
    t.string   "fax"
    t.string   "title"
    t.string   "website"
    t.string   "fb_profile"
    t.string   "twitter_profile"
    t.string   "linkedin"
    t.string   "office_address"
    t.string   "city"
    t.string   "zip_code"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "admin_id",               default: 0,  null: false
    t.integer  "company_id",             default: 0,  null: false
    t.string   "license_number",         default: ""
  end

  create_table "ahoy_events", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.json     "properties"
    t.datetime "time"
  end

  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree

  create_table "approved_emails", force: :cascade do |t|
    t.string   "email",      default: ""
    t.integer  "tour_id",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",              default: "",    null: false
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "is_brokerage",      default: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "detach_units", force: :cascade do |t|
    t.string   "address",    default: ""
    t.integer  "tour_id",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link",       default: ""
  end

  create_table "display_options", force: :cascade do |t|
    t.boolean "show_exterior_walkin", default: true
    t.boolean "show_detach_unit",     default: true
    t.text    "tooltip"
    t.integer "tour_id",              default: 0,    null: false
    t.boolean "show_aerial",          default: true
    t.boolean "show_birds_eye",       default: true
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "admin_id",                 default: 0
    t.boolean  "message",                  default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "additional_email_content", default: ""
  end

  create_table "restrict_options", force: :cascade do |t|
    t.boolean "email"
    t.boolean "email_confirmation"
    t.boolean "name"
    t.boolean "message"
    t.boolean "phone"
    t.boolean "agent_approval"
    t.boolean "send_inquire"
    t.boolean "walkintour"
    t.boolean "google45_imagery"
    t.boolean "exterior_walkin"
    t.boolean "detach_unit"
    t.text    "tooltip"
    t.boolean "restrict_on",        default: false, null: false
    t.integer "tour_id",            default: 0,     null: false
    t.integer "review_seconds",     default: 20
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
  end

  create_table "tour_brandings", force: :cascade do |t|
    t.integer  "tour_id",           default: 0
    t.string   "logo",              default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "logo_width",        default: ""
    t.string   "logo_height",       default: ""
    t.boolean  "is_logo_show",      default: true
  end

  create_table "tours", force: :cascade do |t|
    t.integer  "admin_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "is_agent_branding",     default: true
    t.boolean  "is_display_contents",   default: true
    t.boolean  "is_restriction_option", default: true
    t.boolean  "is_data_log",           default: true
    t.boolean  "is_statistic",          default: true
    t.boolean  "is_tour_branding",      default: true
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "visitor_emails", force: :cascade do |t|
    t.string  "email",       default: "",    null: false
    t.boolean "is_verified", default: false, null: false
  end

  create_table "visitor_logs", force: :cascade do |t|
    t.integer  "visitor_id",       default: 0
    t.integer  "duration_time",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "access_requested", default: false
    t.datetime "visit_time"
    t.string   "name",             default: ""
    t.string   "phone",            default: ""
    t.string   "message",          default: ""
  end

  create_table "visitors", force: :cascade do |t|
    t.string   "ip_address"
    t.datetime "last_visit_time"
    t.string   "country"
    t.string   "browser"
    t.string   "name"
    t.text     "notes"
    t.text     "tooltip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
    t.string   "token"
    t.string   "phone"
    t.text     "message"
    t.integer  "tour_id",              default: 0,     null: false
    t.boolean  "is_verified",          default: false
    t.boolean  "access_requested",     default: false
    t.integer  "duration_time",        default: 0
    t.integer  "visitor_email_id",     default: 0
    t.string   "approve_access_token", default: ""
  end

  create_table "visits", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "visitor_id"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.integer  "screen_height"
    t.integer  "screen_width"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

  create_table "webplayer_basics", force: :cascade do |t|
    t.string   "height"
    t.string   "width"
    t.text     "tooltip"
    t.integer  "tour_id",            default: 0,           null: false
    t.string   "tour_address"
    t.string   "matterport_link"
    t.string   "brand"
    t.string   "media"
    t.boolean  "is_brand_show",      default: true
    t.boolean  "is_media_show",      default: true
    t.string   "brand_width"
    t.string   "brand_height"
    t.string   "media_width"
    t.string   "media_height"
    t.string   "brand_file_name"
    t.string   "brand_content_type"
    t.integer  "brand_file_size"
    t.datetime "brand_updated_at"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.string   "exterior_link",      default: ""
    t.string   "default_unit_name",  default: "Main Unit"
    t.string   "ad_link",            default: ""
  end

end
