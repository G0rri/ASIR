from django.urls import path
from . import views

urlpatterns = [
    path('members/', views.members, name='members'),
    path('jander/', views.jander, name='jander'),
    path('clander/', views.clander, name='clander'),
    path('mycourts/', views.court, name='court'),
    path('members/details/<int:id>', views.details_member, name='details_member'),
    path('courts/new', views.court_new, name='court_new'),
    path('members/new', views.member_new, name='member_new')
]
""" path('courts/details/<int:id>', views.details_court, name='details_court'),
    path('courts/delete/<int:id>', views.delete_court, name='delete_court'),
    path('members/delete/<int:id>', views.delete_member, name='delete_member'),
     """