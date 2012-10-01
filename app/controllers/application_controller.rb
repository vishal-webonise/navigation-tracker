class ApplicationController < ActionController::Base
	include UsersHelper
	protect_from_forgery
end
