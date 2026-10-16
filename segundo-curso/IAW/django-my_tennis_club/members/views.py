from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from .models import Member
from .models import Court
from .forms import CourtForm, MemberForm

def members(request):
    mymembers = Member.objects.all().values()
    template = loader.get_template('all_member.html')  # Cambiado a 'all_member.html'
    context = {
        'mymembers': mymembers,
    }
    return HttpResponse(template.render(context, request))

def jander(request):
    template = loader.get_template('mysecond.html')
    return HttpResponse(template.render())

def clander(request):
    template = loader.get_template('mythird.html')
    return HttpResponse(template.render())

def court(request):
    mycourts = Court.objects.all().values()
    template = loader.get_template('all_courts.html')
    context = {
        'mycourts': mycourts,
    }
    return HttpResponse(template.render(context, request))

def details_member(request, id):
  mymember = Member.objects.get(id=id)
  template = loader.get_template('details_member.html')
  context = {
    'mymember': mymember,
  }
  return HttpResponse(template.render(context, request))

"""def member_delete(request, id):
  Member.objects.get(id=id).delete()
  return HttpResponse('/members')

def court_delete(request, id):
  Court.objects.get(id=id).delete()
  return HttpResponse('/courts')"""

def court_new(request):
    if request.method == 'POST':
        form = CourtForm(request.POST)
        if form.is_valid():
            mycourt = Court(
                description=form.cleaned_data['description'],
                court_type=form.cleaned_data['court_type']
            )
            mycourt.save()
            return HttpResponseRedirect('/mycourts')
    else:
        template = loader.get_template('form_court.html')
        context = {
            'myform': CourtForm
        }
        return HttpResponse(template.render(context, request))
    
def member_new(request):
    if request.method == 'POST':
        form = MemberForm(request.POST)
        if form.is_valid():
            mymember = Member(
                firstname=form.cleaned_data['firstname'],
                lastname=form.cleaned_data['lastname'],
                phone=form.cleaned_data['phone'],
                joined_date=form.cleaned_data['joined_date']
            )
            mymember.save()
            return HttpResponseRedirect('/members')
    else:
        template = loader.get_template('form_members.html')
        context = {
            'myform': MemberForm()
        }
        return HttpResponse(template.render(context, request))