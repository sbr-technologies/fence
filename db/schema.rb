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

ActiveRecord::Schema.define(version: 20160428092944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_addresses", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "zip_suffix_code"
    t.boolean  "is_primary"
    t.string   "directions"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "business_addresses", ["business_id"], name: "index_business_addresses_on_business_id", using: :btree

  create_table "business_contact_people", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "job_title"
    t.string   "department"
    t.text     "contact_notes"
    t.string   "email_address1"
    t.string   "email_address2"
    t.string   "email_address3"
    t.string   "phone_number1"
    t.string   "phone_number2"
    t.string   "phone_number3"
    t.string   "phone_ext1"
    t.string   "phone_ext2"
    t.string   "phone_ext3"
    t.integer  "phone_type_code1"
    t.integer  "phone_type_code2"
    t.integer  "phone_type_code3"
    t.integer  "phone_item_code1"
    t.integer  "phone_item_code2"
    t.integer  "phone_item_code3"
    t.integer  "email_type_code1"
    t.integer  "email_type_code2"
    t.integer  "email_type_code3"
    t.integer  "email_item_code1"
    t.integer  "email_item_code2"
    t.integer  "email_item_code3"
    t.integer  "contact_type_code"
    t.integer  "contact_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "business_contact_people", ["business_id"], name: "index_business_contact_people_on_business_id", using: :btree

  create_table "business_phones", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "phone_number"
    t.string   "phone_number_ext"
    t.boolean  "is_primary"
    t.integer  "phone_type_code"
    t.integer  "phone_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "business_phones", ["business_id"], name: "index_business_phones_on_business_id", using: :btree

  create_table "businesses", force: :cascade do |t|
    t.string   "business_name"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "license_number"
    t.string   "website_address"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "end_reason_type_code"
    t.integer  "end_reason_item_code"
    t.text     "end_reason_notes"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "contract_proposals", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "customer_id"
    t.date     "proposal_date"
    t.string   "job_number"
    t.string   "job_description"
    t.text     "job_long_description"
    t.string   "approx_start_date"
    t.string   "approx_completion_date"
    t.date     "start_date"
    t.date     "completion_date"
    t.float    "advance_payment"
    t.float    "proposal_amount"
    t.date     "signed_date"
    t.string   "signed_by_lastname"
    t.string   "signed_by_firstname"
    t.string   "signed_by_mi"
    t.integer  "prepared_by"
    t.text     "job_status_notes"
    t.integer  "cp_proposal_terms_type_code"
    t.integer  "cp_proposal_terms_item_code"
    t.integer  "cp_payment_terms_type_code"
    t.integer  "cp_payment_terms_item_code"
    t.text     "cp_proposal_terms"
    t.text     "cp_payment_terms"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "contract_proposals", ["business_id"], name: "index_contract_proposals_on_business_id", using: :btree
  add_index "contract_proposals", ["customer_id"], name: "index_contract_proposals_on_customer_id", using: :btree

  create_table "cp_pg_products", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "cp_project_group_id"
    t.integer  "project_group_id"
    t.integer  "product_id"
    t.decimal  "retail_price",        default: 0.0
    t.integer  "quantity",            default: 0
    t.integer  "labor_hours",         default: 0
    t.decimal  "labor_cost",          default: 0.0
    t.integer  "uom_type_code"
    t.integer  "uom_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "cp_pg_products", ["business_id"], name: "index_cp_pg_products_on_business_id", using: :btree
  add_index "cp_pg_products", ["cp_project_group_id"], name: "index_cp_pg_products_on_cp_project_group_id", using: :btree
  add_index "cp_pg_products", ["product_id"], name: "index_cp_pg_products_on_product_id", using: :btree
  add_index "cp_pg_products", ["project_group_id"], name: "index_cp_pg_products_on_project_group_id", using: :btree

  create_table "cp_project_groups", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "project_group_id"
    t.integer  "contract_proposal_id"
    t.string   "cp_pg_description"
    t.text     "cp_pg_long_description"
    t.float    "cp_pg_amount",           default: 0.0
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "cp_project_groups", ["business_id"], name: "index_cp_project_groups_on_business_id", using: :btree
  add_index "cp_project_groups", ["contract_proposal_id"], name: "index_cp_project_groups_on_contract_proposal_id", using: :btree
  add_index "cp_project_groups", ["project_group_id"], name: "index_cp_project_groups_on_project_group_id", using: :btree

  create_table "customer_addresses", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "customer_id"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "zip_suffix_code"
    t.boolean  "is_primary"
    t.string   "directions"
    t.integer  "address_type_code"
    t.integer  "address_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "customer_addresses", ["business_id"], name: "index_customer_addresses_on_business_id", using: :btree
  add_index "customer_addresses", ["customer_id"], name: "index_customer_addresses_on_customer_id", using: :btree

  create_table "customer_contact_people", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "customer_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "job_title"
    t.string   "department"
    t.text     "contact_notes"
    t.string   "email_address1"
    t.string   "email_address2"
    t.string   "email_address3"
    t.string   "phone_number1"
    t.string   "phone_number2"
    t.string   "phone_number3"
    t.string   "phone_ext1"
    t.string   "phone_ext2"
    t.string   "phone_ext3"
    t.integer  "phone_type_code1"
    t.integer  "phone_type_code2"
    t.integer  "phone_type_code3"
    t.integer  "phone_item_code1"
    t.integer  "phone_item_code2"
    t.integer  "phone_item_code3"
    t.integer  "email_type_code1"
    t.integer  "email_type_code2"
    t.integer  "email_type_code3"
    t.integer  "email_item_code1"
    t.integer  "email_item_code2"
    t.integer  "email_item_code3"
    t.integer  "contact_type_code"
    t.integer  "contact_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "customer_contact_people", ["business_id"], name: "index_customer_contact_people_on_business_id", using: :btree
  add_index "customer_contact_people", ["customer_id"], name: "index_customer_contact_people_on_customer_id", using: :btree

  create_table "customer_phones", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "customer_id"
    t.string   "phone_number"
    t.string   "phone_number_ext"
    t.boolean  "is_primary"
    t.integer  "phone_type_code"
    t.integer  "phone_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "customer_phones", ["business_id"], name: "index_customer_phones_on_business_id", using: :btree
  add_index "customer_phones", ["customer_id"], name: "index_customer_phones_on_customer_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.decimal  "margin_percent",        default: 0.0
    t.string   "business_name"
    t.string   "business_account_nmbr"
    t.text     "end_reason_notes"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "end_reason_type_code"
    t.integer  "end_reason_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "customers", ["business_id"], name: "index_customers_on_business_id", using: :btree

  create_table "employee_addresses", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "employee_id"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "zip_suffix_code"
    t.boolean  "is_primary"
    t.string   "directions"
    t.integer  "address_type_code"
    t.integer  "address_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "employee_addresses", ["business_id"], name: "index_employee_addresses_on_business_id", using: :btree
  add_index "employee_addresses", ["employee_id"], name: "index_employee_addresses_on_employee_id", using: :btree

  create_table "employee_phones", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "employee_id"
    t.string   "phone_number"
    t.string   "phone_number_ext"
    t.boolean  "is_primary"
    t.integer  "phone_type_code"
    t.integer  "phone_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "employee_phones", ["business_id"], name: "index_employee_phones_on_business_id", using: :btree
  add_index "employee_phones", ["employee_id"], name: "index_employee_phones_on_employee_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "job_title"
    t.string   "department"
    t.string   "subcontractor_name"
    t.integer  "employee_number"
    t.string   "ssn"
    t.decimal  "hourly_rate"
    t.decimal  "gross_salary"
    t.decimal  "taxes"
    t.decimal  "net_salary"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "end_reason_notes"
    t.integer  "end_reason_type_code"
    t.integer  "end_reason_item_code"
    t.text     "contact_notes"
    t.string   "email_address1"
    t.string   "email_address2"
    t.string   "email_address3"
    t.string   "phone_number1"
    t.string   "phone_number2"
    t.string   "phone_number3"
    t.string   "phone_ext1"
    t.string   "phone_ext2"
    t.string   "phone_ext3"
    t.integer  "phone_type_code1"
    t.integer  "phone_type_code2"
    t.integer  "phone_type_code3"
    t.integer  "phone_item_code1"
    t.integer  "phone_item_code2"
    t.integer  "phone_item_code3"
    t.integer  "email_type_code1"
    t.integer  "email_type_code2"
    t.integer  "email_type_code3"
    t.integer  "email_item_code1"
    t.integer  "email_item_code2"
    t.integer  "email_item_code3"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "employee_type_code"
    t.integer  "employee_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "employees", ["business_id"], name: "index_employees_on_business_id", using: :btree

  create_table "lookup_item_codes", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "lookup_type_code_id"
    t.string   "description"
    t.text     "long_description"
    t.boolean  "active"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "lookup_item_codes", ["business_id"], name: "index_lookup_item_codes_on_business_id", using: :btree
  add_index "lookup_item_codes", ["lookup_type_code_id"], name: "index_lookup_item_codes_on_lookup_type_code_id", using: :btree

  create_table "lookup_type_codes", force: :cascade do |t|
    t.string   "description"
    t.text     "long_description"
    t.boolean  "active"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "manufacturer_addresses", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "manufacturer_id"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "zip_suffix_code"
    t.boolean  "is_primary"
    t.string   "directions"
    t.integer  "address_type_code"
    t.integer  "address_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "manufacturer_addresses", ["business_id"], name: "index_manufacturer_addresses_on_business_id", using: :btree
  add_index "manufacturer_addresses", ["manufacturer_id"], name: "index_manufacturer_addresses_on_manufacturer_id", using: :btree

  create_table "manufacturer_contact_people", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "manufacturer_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "job_title"
    t.string   "department"
    t.text     "contact_notes"
    t.string   "email_address1"
    t.string   "email_address2"
    t.string   "email_address3"
    t.string   "phone_number1"
    t.string   "phone_number2"
    t.string   "phone_number3"
    t.string   "phone_ext1"
    t.string   "phone_ext2"
    t.string   "phone_ext3"
    t.integer  "phone_type_code1"
    t.integer  "phone_type_code2"
    t.integer  "phone_type_code3"
    t.integer  "phone_item_code1"
    t.integer  "phone_item_code2"
    t.integer  "phone_item_code3"
    t.integer  "email_type_code1"
    t.integer  "email_type_code2"
    t.integer  "email_type_code3"
    t.integer  "email_item_code1"
    t.integer  "email_item_code2"
    t.integer  "email_item_code3"
    t.integer  "contact_type_code"
    t.integer  "contact_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "manufacturer_contact_people", ["business_id"], name: "index_manufacturer_contact_people_on_business_id", using: :btree
  add_index "manufacturer_contact_people", ["manufacturer_id"], name: "index_manufacturer_contact_people_on_manufacturer_id", using: :btree

  create_table "manufacturer_phones", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "manufacturer_id"
    t.string   "phone_number"
    t.string   "phone_number_ext"
    t.boolean  "is_primary"
    t.integer  "phone_type_code"
    t.integer  "phone_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "manufacturer_phones", ["business_id"], name: "index_manufacturer_phones_on_business_id", using: :btree
  add_index "manufacturer_phones", ["manufacturer_id"], name: "index_manufacturer_phones_on_manufacturer_id", using: :btree

  create_table "manufacturers", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "business_name"
    t.string   "business_account_number"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "end_reason_type_code"
    t.integer  "end_reason_item_code"
    t.text     "end_reason_notes"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "manufacturers", ["business_id"], name: "index_manufacturers_on_business_id", using: :btree

  create_table "pg_products", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "project_group_id"
    t.integer  "product_id"
    t.string   "pg_product_description"
    t.text     "pg_product_long_description"
    t.integer  "quantity"
    t.integer  "labor_hours"
    t.decimal  "labor_cost"
    t.integer  "uom_type_code"
    t.integer  "uom_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "pg_products", ["business_id"], name: "index_pg_products_on_business_id", using: :btree
  add_index "pg_products", ["product_id"], name: "index_pg_products_on_product_id", using: :btree
  add_index "pg_products", ["project_group_id"], name: "index_pg_products_on_project_group_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "manufacturer_id"
    t.string   "product_sku"
    t.string   "product_name"
    t.float    "cost_price"
    t.float    "retail_price"
    t.string   "description"
    t.text     "long_description"
    t.integer  "preferred_supplier_id"
    t.integer  "category_type_code"
    t.integer  "category_item_code"
    t.integer  "uom_type_code"
    t.integer  "uom_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "products", ["business_id"], name: "index_products_on_business_id", using: :btree
  add_index "products", ["manufacturer_id"], name: "index_products_on_manufacturer_id", using: :btree

  create_table "project_groups", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "project_group_name"
    t.string   "project_group_description"
    t.text     "project_group_long_description"
    t.integer  "category_type_code"
    t.integer  "category_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "project_groups", ["business_id"], name: "index_project_groups_on_business_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "level"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_addresses", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "supplier_id"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "zip_suffix_code"
    t.boolean  "is_primary"
    t.string   "directions"
    t.integer  "address_type_code"
    t.integer  "address_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "supplier_addresses", ["business_id"], name: "index_supplier_addresses_on_business_id", using: :btree
  add_index "supplier_addresses", ["supplier_id"], name: "index_supplier_addresses_on_supplier_id", using: :btree

  create_table "supplier_contact_people", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "supplier_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "job_title"
    t.string   "department"
    t.text     "contact_notes"
    t.string   "email_address1"
    t.string   "email_address2"
    t.string   "email_address3"
    t.string   "phone_number1"
    t.string   "phone_number2"
    t.string   "phone_number3"
    t.string   "phone_ext1"
    t.string   "phone_ext2"
    t.string   "phone_ext3"
    t.integer  "phone_type_code1"
    t.integer  "phone_type_code2"
    t.integer  "phone_type_code3"
    t.integer  "phone_item_code1"
    t.integer  "phone_item_code2"
    t.integer  "phone_item_code3"
    t.integer  "email_type_code1"
    t.integer  "email_type_code2"
    t.integer  "email_type_code3"
    t.integer  "email_item_code1"
    t.integer  "email_item_code2"
    t.integer  "email_item_code3"
    t.integer  "contact_type_code"
    t.integer  "contact_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "supplier_contact_people", ["business_id"], name: "index_supplier_contact_people_on_business_id", using: :btree
  add_index "supplier_contact_people", ["supplier_id"], name: "index_supplier_contact_people_on_supplier_id", using: :btree

  create_table "supplier_phones", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "supplier_id"
    t.string   "phone_number"
    t.string   "phone_number_ext"
    t.boolean  "is_primary"
    t.integer  "phone_type_code"
    t.integer  "phone_item_code"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "supplier_phones", ["business_id"], name: "index_supplier_phones_on_business_id", using: :btree
  add_index "supplier_phones", ["supplier_id"], name: "index_supplier_phones_on_supplier_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "business_name"
    t.string   "business_account_number"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "end_reason_type_code"
    t.integer  "end_reason_item_code"
    t.text     "end_reason_notes"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "suppliers", ["business_id"], name: "index_suppliers_on_business_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role_id"
    t.integer  "business_id"
    t.integer  "employee_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "end_reason_type_code"
    t.integer  "end_reason_item_code"
    t.text     "end_reason_notes"
    t.integer  "status_type_code"
    t.integer  "status_item_code"
  end

  add_index "users", ["business_id"], name: "index_users_on_business_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["employee_id"], name: "index_users_on_employee_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "business_addresses", "businesses"
  add_foreign_key "business_contact_people", "businesses"
  add_foreign_key "business_phones", "businesses"
  add_foreign_key "contract_proposals", "businesses"
  add_foreign_key "contract_proposals", "customers"
  add_foreign_key "cp_pg_products", "businesses"
  add_foreign_key "cp_pg_products", "cp_project_groups"
  add_foreign_key "cp_pg_products", "products"
  add_foreign_key "cp_pg_products", "project_groups"
  add_foreign_key "cp_project_groups", "businesses"
  add_foreign_key "cp_project_groups", "contract_proposals"
  add_foreign_key "cp_project_groups", "project_groups"
  add_foreign_key "customer_addresses", "businesses"
  add_foreign_key "customer_addresses", "customers"
  add_foreign_key "customer_contact_people", "businesses"
  add_foreign_key "customer_contact_people", "customers"
  add_foreign_key "customer_phones", "businesses"
  add_foreign_key "customer_phones", "customers"
  add_foreign_key "customers", "businesses"
  add_foreign_key "employee_addresses", "businesses"
  add_foreign_key "employee_addresses", "employees"
  add_foreign_key "employee_phones", "businesses"
  add_foreign_key "employee_phones", "employees"
  add_foreign_key "employees", "businesses"
  add_foreign_key "lookup_item_codes", "businesses"
  add_foreign_key "lookup_item_codes", "lookup_type_codes"
  add_foreign_key "manufacturer_addresses", "businesses"
  add_foreign_key "manufacturer_addresses", "manufacturers"
  add_foreign_key "manufacturer_contact_people", "businesses"
  add_foreign_key "manufacturer_contact_people", "manufacturers"
  add_foreign_key "manufacturer_phones", "businesses"
  add_foreign_key "manufacturer_phones", "manufacturers"
  add_foreign_key "manufacturers", "businesses"
  add_foreign_key "pg_products", "businesses"
  add_foreign_key "pg_products", "products"
  add_foreign_key "pg_products", "project_groups"
  add_foreign_key "products", "businesses"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "project_groups", "businesses"
  add_foreign_key "supplier_addresses", "businesses"
  add_foreign_key "supplier_addresses", "suppliers"
  add_foreign_key "supplier_contact_people", "businesses"
  add_foreign_key "supplier_contact_people", "suppliers"
  add_foreign_key "supplier_phones", "businesses"
  add_foreign_key "supplier_phones", "suppliers"
  add_foreign_key "suppliers", "businesses"
  add_foreign_key "users", "businesses"
  add_foreign_key "users", "employees"
end
