select m.MountainRange, p.PeakName, p.Elevation 
from Mountains as m
join Peaks as p on m.Id = p.MountainId
where m.Id = 17
order by p.Elevation desc