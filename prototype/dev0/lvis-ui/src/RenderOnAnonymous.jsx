import UserService from "./state/UserService";

const RenderOnAnonymous = ({ children }) => (!UserService.isLoggedIn()) ? children : null;

export default RenderOnAnonymous
