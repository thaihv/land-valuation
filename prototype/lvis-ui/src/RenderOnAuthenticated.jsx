import UserService from "./state/UserService";

const RenderOnAuthenticated = ({ children }) => (UserService.isLoggedIn()) ? children : null;

export default RenderOnAuthenticated
