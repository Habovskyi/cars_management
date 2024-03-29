# frozen_string_literal: true

require 'colorize'
require 'i18n'
require 'terminal-table'
require 'date'
require 'yaml'
require 'bcrypt'
require_relative 'database'
require_relative 'operations/searcher'
require_relative 'updater/data_updater'
require_relative 'operations/sorter'
require_relative 'operations/statistic'
require_relative 'console/console'
require_relative 'validator/validator'
require_relative 'app'
require_relative 'user/user'
require_relative 'user/user_searches'
require_relative 'console/menu'
require_relative 'administrator'
require_relative 'operations/fast_search'
require_relative 'user/authentication'
require_relative '../config/i18n_config'
