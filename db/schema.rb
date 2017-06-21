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

ActiveRecord::Schema.define(version: 20170620073954) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "login"
    t.string   "password_digest"
    t.integer  "dgt_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "status"
  end

  create_table "attchments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pact_id"
    t.string   "attchment"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "userid"
    t.string   "attchmentimg_file_name"
    t.string   "attchmentimg_content_type"
    t.integer  "attchmentimg_file_size"
    t.datetime "attchmentimg_updated_at"
  end

  create_table "busines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "address"
    t.string   "province"
    t.string   "city"
    t.string   "districe"
    t.string   "contact"
    t.string   "contactphone"
    t.string   "buessphone"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "busine_id"
  end

  create_table "buycars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ordernumber"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "remark"
    t.float    "amount",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "openid"
    t.integer  "status"
  end

  create_table "deliveorders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "delive"
    t.integer  "buycar_id"
    t.integer  "dgt_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ordernumber"
  end

  create_table "delives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "delive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dgtfees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dgt_id"
    t.float    "amount",     limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "status"
  end

  create_table "dgts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "phone"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.float    "amount",     limit: 24
    t.float    "amountsub",  limit: 24
  end

  create_table "giveawaybusines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "busine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "giveaways", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "enable"
    t.datetime "begindate"
    t.datetime "enddate"
    t.integer  "buyproduct_id"
    t.integer  "giveproduct_id"
    t.integer  "buynum"
    t.integer  "givenum"
    t.integer  "once"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "idcards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "User_id"
    t.string   "uuid"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "idfront_file_name"
    t.string   "idfront_content_type"
    t.integer  "idfront_file_size"
    t.datetime "idfront_updated_at"
    t.string   "idback_file_name"
    t.string   "idback_content_type"
    t.integer  "idback_file_size"
    t.datetime "idback_updated_at"
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "busine_id"
    t.string   "ordernumber"
    t.float    "paymentamount", limit: 24
    t.integer  "status"
    t.string   "remark"
    t.string   "linkparams"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.integer  "number"
    t.integer  "product_id"
    t.integer  "buycar_id"
  end

  create_table "pacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "busine_id"
    t.integer  "user_id"
    t.string   "number"
    t.datetime "begindate"
    t.datetime "enddate"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dgt_id"
    t.string   "name"
    t.string   "unit"
    t.float    "price",                   limit: 24
    t.text     "detail",                  limit: 65535
    t.text     "spec",                    limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "productimg_file_name"
    t.string   "productimg_content_type"
    t.integer  "productimg_file_size"
    t.datetime "productimg_updated_at"
    t.float    "businepro",               limit: 24
    t.float    "dgtpro",                  limit: 24
  end

  create_table "profits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "dgt"
    t.string   "product"
    t.integer  "number"
    t.float    "profit",     limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "testlogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "log",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "useramounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.float    "amount",     limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "content"
  end

  create_table "userprofits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.float    "amount",     limit: 24
    t.string   "content"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "userpwds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "login"
    t.string   "password_digest"
    t.string   "phonecode"
    t.datetime "phonecodetime"
    t.float    "balance",                limit: 24
    t.integer  "isnew"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "idfontimg_file_name"
    t.string   "idfontimg_content_type"
    t.integer  "idfontimg_file_size"
    t.datetime "idfontimg_updated_at"
    t.string   "idbackimg_file_name"
    t.string   "idbackimg_content_type"
    t.integer  "idbackimg_file_size"
    t.datetime "idbackimg_updated_at"
    t.integer  "status"
    t.string   "userpwd_digest"
  end

  create_table "wxusers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "openid"
    t.string   "nickname"
    t.integer  "sex"
    t.string   "address"
    t.string   "headimgurl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "dgt_id"
    t.integer  "receipt"
  end

end
