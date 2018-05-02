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

ActiveRecord::Schema.define(version: 20180326213447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "claims", force: :cascade do |t|
    t.string "facility_name"
    t.datetime "date"
    t.string "authorization_number"
    t.decimal "total_requested_amount", default: "0.0"
    t.decimal "authorized_amount", default: "0.0"
    t.decimal "rejected_amount", default: "0.0"
    t.string "authority_name"
    t.bigint "provider_id"
    t.string "authority_designation"
    t.string "member_number"
    t.integer "status", default: 0
    t.bigint "insurer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment"
    t.text "description"
    t.string "member_name"
    t.text "reject_reason"
    t.text "insurer_comment"
    t.json "attachments"
    t.string "claim_no"
    t.index ["insurer_id"], name: "index_claims_on_insurer_id"
    t.index ["provider_id"], name: "index_claims_on_provider_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "plan"
    t.string "contact"
    t.bigint "insurer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurer_id"], name: "index_companies_on_insurer_id"
  end

  create_table "dependants", force: :cascade do |t|
    t.string "surname"
    t.string "firstname"
    t.string "middlename"
    t.datetime "dob"
    t.string "sex"
    t.string "blood_group"
    t.string "primary_hospital"
    t.string "secondary_hospital"
    t.string "genotype"
    t.string "photo"
    t.bigint "enrolee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dependant_type"
    t.string "enrolee_number"
    t.boolean "card_issued", default: false
    t.datetime "expiry_date", default: "2019-05-01 22:13:28"
    t.string "location"
    t.bigint "insurer_id"
    t.string "plan"
    t.string "phone"
    t.index ["enrolee_id"], name: "index_dependants_on_enrolee_id"
    t.index ["insurer_id"], name: "index_dependants_on_insurer_id"
  end

  create_table "enrolees", force: :cascade do |t|
    t.string "surname"
    t.string "firstname"
    t.string "middlename"
    t.string "company_id"
    t.string "enrolee_number"
    t.string "primary_provider"
    t.string "secondary_provider"
    t.string "tertiary_provider"
    t.string "phone"
    t.string "email"
    t.text "address"
    t.datetime "dob"
    t.string "sex"
    t.string "state"
    t.string "cover_status", default: "active"
    t.boolean "card_issued", default: false
    t.string "plan"
    t.datetime "expiry_date"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "insurer_id"
    t.string "location"
    t.datetime "date"
    t.string "company_name"
    t.index ["insurer_id"], name: "index_enrolees_on_insurer_id"
  end

  create_table "insurers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.string "address"
    t.string "phone"
    t.text "description"
    t.string "facebook"
    t.string "twitter"
    t.string "google_plus"
    t.string "website"
    t.string "photo"
    t.index ["email"], name: "index_insurers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_insurers_on_reset_password_token", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "insurer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurer_id"], name: "index_plans_on_insurer_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.string "facility_type"
    t.string "category"
    t.string "region"
    t.string "phone"
    t.text "address"
    t.string "payment_option"
    t.string "acc_no"
    t.string "acc_name"
    t.string "acc_bank"
    t.string "photo"
    t.index ["email"], name: "index_providers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_providers_on_reset_password_token", unique: true
  end

  create_table "services", force: :cascade do |t|
    t.string "service_type"
    t.string "name"
    t.decimal "cost", default: "0.0"
    t.integer "qty", default: 1
    t.text "description"
    t.bigint "claim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", default: "none"
    t.decimal "total_cost"
    t.decimal "vetted_cost"
    t.index ["claim_id"], name: "index_services_on_claim_id"
  end

  add_foreign_key "claims", "insurers"
  add_foreign_key "claims", "providers"
  add_foreign_key "companies", "insurers"
  add_foreign_key "dependants", "enrolees"
  add_foreign_key "dependants", "insurers"
  add_foreign_key "enrolees", "insurers"
  add_foreign_key "plans", "insurers"
  add_foreign_key "services", "claims"
end
