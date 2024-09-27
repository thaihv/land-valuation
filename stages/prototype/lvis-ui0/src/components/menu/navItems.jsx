import SearchOutlinedIcon from '@mui/icons-material/SearchOutlined';
import AirplayOutlinedIcon from '@mui/icons-material/AirplayOutlined';
import RoomOutlinedIcon from '@mui/icons-material/RoomOutlined';
import CommentOutlinedIcon from '@mui/icons-material/CommentOutlined';
import AssignmentOutlinedIcon from '@mui/icons-material/AssignmentOutlined';
import BackupTableOutlinedIcon from '@mui/icons-material/BackupTableOutlined';

export const navItems = [
  {
    text: "Search",
    link: "Search",
    icon: <SearchOutlinedIcon />,
  },
  {
    text: "Preparation",
    link: "Myteam",
    icon: <AirplayOutlinedIcon/>,
  },
  {
    text: "Data Collection",
    link: "Products",
    icon: <RoomOutlinedIcon />,
  },  
  {
    text: "Assessment Activity",
    link: "Survey",
    icon: <CommentOutlinedIcon />,
  },
  {
    text: "Approval",
    link: "Transactions",
    icon: <AssignmentOutlinedIcon />,
  },  
  {
    text: "Publish",
    link: "Tasks",
    icon: <BackupTableOutlinedIcon />,
  },
];
